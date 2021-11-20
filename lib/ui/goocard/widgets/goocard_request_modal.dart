import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pengo/bloc/goocard/goocard_bloc.dart';
import 'package:pengo/config/color.dart';
import 'package:pengo/const/space_const.dart';
import 'package:pengo/helpers/theme/custom_font.dart';
import 'package:pengo/helpers/theme/theme_helper.dart';
import 'package:pengo/helpers/toast/toast_helper.dart';
import 'package:pengo/ui/goocard/widgets/pincode.dart';
import 'package:pengo/ui/widgets/button/custom_button.dart';

class GoocardRequestModal extends StatefulWidget {
  const GoocardRequestModal({
    Key? key,
    this.onVerifySuccess,
    this.onVerifyFailed,
  }) : super(key: key);

  final ValueSetter<String>? onVerifySuccess;
  final VoidCallback? onVerifyFailed;

  @override
  State<GoocardRequestModal> createState() => _GoocardRequestModalState();
}

class _GoocardRequestModalState extends State<GoocardRequestModal> {
  late TextEditingController _pinController;

  final GoocardBloc _goocardBloc = GoocardBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GoocardBloc>(
      create: (BuildContext context) => _goocardBloc,
      child: Container(
        color: whiteColor,
        height: mediaQuery(context).size.height * 0.3,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Enter pin:",
              style: PengoStyle.header(context),
            ),
            const SizedBox(
              height: 18,
            ),
            GooCardPinCode(
              controller: _pinController,
            ),
            const Spacer(),
            BlocConsumer<GoocardBloc, GoocardState>(
              listener: (BuildContext context, GoocardState state) {
                if (state is GoocardVeriyFailed) {
                  showToast(
                    msg: state.e.toString(),
                  );
                  if (widget.onVerifyFailed != null) {
                    // ignore: prefer_null_aware_method_calls
                    widget.onVerifyFailed!();
                  }
                } else if (state is GoocardVerifySuccess) {
                  showToast(
                    msg: state.response.msg ?? "Success",
                    backgroundColor: successColor,
                  );

                  if (widget.onVerifySuccess != null) {
                    // ignore: prefer_null_aware_method_calls
                    widget.onVerifySuccess!(_pinController.text);
                  }
                }
              },
              builder: (BuildContext context, GoocardState state) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: CustomButton(
                    onPressed: _verify,
                    isLoading: state is GoocardVerifying,
                    text: const Text("Verify"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _verify() {
    _goocardBloc.add(VerifyGooCard(_pinController.text));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinController.dispose();
  }
}
