import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignupState extends Equatable {}

class SignupLoading extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupSuccess extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupFaild extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupError extends SignupState {
  final String error;

  SignupError(this.error);
  @override
  List<Object?> get props => [error];
}
