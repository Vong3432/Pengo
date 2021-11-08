// payment_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/api/api_helper.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/ui/payment/widgets/payment_gateway_item.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.pengerId,
    required this.bookingItemId,
    this.onSuccessCallback,
    this.onFailureCallback,
    this.couponId,
  }) : super(key: key);

  final int pengerId;
  final int bookingItemId;
  final int? couponId;
  final VoidCallback? onSuccessCallback;
  final VoidCallback? onFailureCallback;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Future<void> _checkout() async {
    try {
      final Map<String, dynamic> paymentData = <String, dynamic>{
        "target_holder_id": widget.pengerId,
        "booking_item_id": widget.bookingItemId,
      };

      if (widget.couponId != null) {
        paymentData["coupon_id"] = widget.couponId;
      }

      /// retrieve data from the backend
      final response =
          await ApiHelper().post("/pengoo/payments", data: paymentData);
      final _paymentSheetData = response.data!['data'] as Map<String, dynamic>;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.dark,
          testEnv: true,
          merchantCountryCode: 'MYR',
          merchantDisplayName: 'Booking',
          customerId: _paymentSheetData["customer"].toString(),
          paymentIntentClientSecret: "${_paymentSheetData['client_secret']}",
          // customerEphemeralKeySecret: "${_paymentSheetData['ephemeralKey']}",
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      // will be called if success.
      if (widget.onSuccessCallback != null) {
        /// storing transaction to db
        final transactionResponse = await ApiHelper().post(
          "/pengoo/transactions",
          data: {
            "bank_account_id": _paymentSheetData["bank_account_id"],
            "to_bank_account_id": _paymentSheetData["to_bank_account_id"],
            "amount": _paymentSheetData["amount"],
            "metadata": _paymentSheetData["metadata"],
          },
        );

        if (transactionResponse.statusCode == 200) {
          // ignore: prefer_null_aware_method_calls
          widget.onSuccessCallback!();
        }
      }
    } catch (e) {
      // will be called if fail/cancel.
      if (widget.onFailureCallback != null) {
        // ignore: prefer_null_aware_method_calls
        widget.onFailureCallback!();
      }
    }
  }

  Future<void> _initStripe() async {
    Stripe.publishableKey = dotenv.env['STRIPE_PK'] ?? "";
    Stripe.merchantIdentifier = 'pengo.gg';
    await Stripe.instance.applySettings();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initStripe();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Payment gateways",
              style: PengoStyle.title2(context).copyWith(
                color: secondaryTextColor,
              ),
            ),
          ),
          const SizedBox(height: SECTION_GAP_HEIGHT * 2),
          GestureDetector(
            onTap: _checkout,
            child: const PaymentGatewayItem(name: "Pay with credit card"),
          ),
        ],
      ),
    );
  }
}
