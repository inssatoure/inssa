import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'forget_password_state.dart';

part 'forget_password_event.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final AuthenticationService authenticationService;

  ForgetPasswordBloc({required this.authenticationService})
      : super(ForgetPasswordFaild()) {
    on<ForgetPasswordRequested>(_onForgetPasswordRequested);
  }

  Future<void> _onForgetPasswordRequested(
      ForgetPasswordRequested event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordLoading());
    await Future.delayed(const Duration(seconds: 2), () {
      try {
        authenticationService.resetPassword(event.context, event.email);

        emit(ForgetPasswordSuccess());
      } catch (error) {
        emit(ForgetPasswordError(error.toString()));
        emit(ForgetPasswordFaild());
      }
    });
  }
}
