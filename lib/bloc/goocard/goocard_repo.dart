import 'package:pengo/bloc/goocard/goocard_api_provider.dart';
import 'package:pengo/bloc/records/booking_record_api_provider.dart';
import 'package:pengo/cubit/booking/booking_form_cubit.dart';
import 'package:pengo/models/booking_record_model.dart';
import 'package:pengo/models/response_model.dart';

class GoocardRepo {
  factory GoocardRepo() {
    return _instance;
  }

  GoocardRepo._constructor();

  static final GoocardRepo _instance = GoocardRepo._constructor();
  final GoocardApiProvider _goocardApiProvider = GoocardApiProvider();

  Future<ResponseModel> verify(String pin) async =>
      _goocardApiProvider.verify(pin);
}
