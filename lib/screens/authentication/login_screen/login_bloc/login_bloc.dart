import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'login_state.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService authenticationService;
  final VoidCallback onLoginCallback;
  LoginBloc(this.onLoginCallback, {required this.authenticationService})
      : super(LoginFaild()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2), () {
      try {
        authenticationService.login(
          event.context,
          event.email,
          event.password,
          () {
            onLoginCallback();
          },
        );

        emit(LoginSuccess());
      } catch (error) {
        emit(LoginError(error.toString()));
        emit(LoginFaild());
      }
    });
  }
}
