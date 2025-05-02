import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_bloc/signup_even.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationService authenticationService;
  SignupBloc({required this.authenticationService}) : super(SignupFaild()) {
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    await Future.delayed(const Duration(seconds: 2), () {
      try {
        authenticationService.registerUser(
            event.context, event.username, event.email, event.password);

        emit(SignupSuccess());
      } catch (error) {
        emit(SignupError(error.toString()));
        emit(SignupFaild());
      }
    });
  }
}
