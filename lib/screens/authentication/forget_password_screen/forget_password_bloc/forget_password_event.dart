part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgetPasswordRequested extends ForgetPasswordEvent {
  final BuildContext context;
  final String email;

  ForgetPasswordRequested(this.email, this.context);
}
