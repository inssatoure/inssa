import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupRequested extends SignupEvent {
  final BuildContext context;
  final String username;
  final String email;
  final String password;

  SignupRequested(this.username, this.email, this.password, this.context);
}
