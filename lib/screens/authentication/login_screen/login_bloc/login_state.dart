import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFaild extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
  @override
  List<Object?> get props => [error];
}
