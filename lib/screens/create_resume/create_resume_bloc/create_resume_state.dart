import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CreateResumeState extends Equatable {}

class CreateResumeLoading extends CreateResumeState {
  @override
  List<Object?> get props => [];
}

class CreateResumeSuccess extends CreateResumeState {
  @override
  List<Object?> get props => [];
}

class CreateResumeFaild extends CreateResumeState {
  @override
  List<Object?> get props => [];
}

class CreateResumeError extends CreateResumeState {
  final String error;

  CreateResumeError(this.error);
  @override
  List<Object?> get props => [error];
}
