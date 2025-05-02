import 'package:equatable/equatable.dart';

abstract class EditResumeState extends Equatable {
  const EditResumeState();

  @override
  List<Object?> get props => [];
}

class EditResumeInitial extends EditResumeState {}

class EditResumeLoading extends EditResumeState {}

class EditResumeLoaded extends EditResumeState {
  final Map<String, dynamic> resumeData;

  const EditResumeLoaded(this.resumeData);

  @override
  List<Object?> get props => [resumeData];
}

class EditResumeTemplateInitial extends EditResumeState {
  final dynamic extra;
  final bool isStart;

  const EditResumeTemplateInitial({required this.extra, required this.isStart});

  @override
  List<Object> get props => [extra, isStart];
}

class EditResumeError extends EditResumeState {
  final String message;

  const EditResumeError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateResumeLoading extends EditResumeState {
  @override
  List<Object?> get props => [];
}

class UpdateResumeSuccess extends EditResumeState {
  @override
  List<Object?> get props => [];
}

class UpdateResumeFaild extends EditResumeState {
  @override
  List<Object?> get props => [];
}

class UpdateResumeError extends EditResumeState {
  final String error;

  const UpdateResumeError(this.error);
  @override
  List<Object?> get props => [error];
}
