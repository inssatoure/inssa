import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ForgetPasswordState extends Equatable {}

class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccess extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordFaild extends ForgetPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordError extends ForgetPasswordState {
  final String error;

  ForgetPasswordError(this.error);
  @override
  List<Object?> get props => [error];
}
