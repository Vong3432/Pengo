import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pengo/bloc/goocard/goocard_repo.dart';
import 'package:pengo/models/response_model.dart';

part 'goocard_event.dart';
part 'goocard_state.dart';

class GoocardBloc extends Bloc<GoocardEvent, GoocardState> {
  GoocardBloc() : super(GoocardInitial()) {
    on<VerifyGooCard>(_verify);
  }

  final GoocardRepo _repo = GoocardRepo();

  Future<void> _verify(VerifyGooCard event, Emitter<GoocardState> emit) async {
    try {
      emit(GoocardVerifying());
      final ResponseModel response = await _repo.verify(event.pin);
      emit(GoocardVerifySuccess(response));
    } catch (e) {
      emit(GoocardVeriyFailed(e));
    }
  }
}
