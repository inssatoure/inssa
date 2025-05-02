part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  LoginRequested(this.email, this.password, this.context);
}
