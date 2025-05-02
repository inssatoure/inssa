import 'package:equatable/equatable.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';

abstract class ResumeTempleteListState extends Equatable {
  const ResumeTempleteListState();

  @override
  List<Object> get props => [];
}

class ResumeTempleteListInitial extends ResumeTempleteListState {}

class ResumeTempleteListLoading extends ResumeTempleteListState {}

class ResumeTempleteListLoaded extends ResumeTempleteListState {
  final List<QuickResumeData> resumes;

  const ResumeTempleteListLoaded(this.resumes);

  @override
  List<Object> get props => [resumes];
}

class ResumeTempleteListError extends ResumeTempleteListState {
  final String message;

  const ResumeTempleteListError(this.message);

  @override
  List<Object> get props => [message];
}

class ResumeDeleted extends ResumeTempleteListState {}

class ResumeError extends ResumeTempleteListState {
  final String message;

  const ResumeError(this.message);

  @override
  List<Object> get props => [message];
}

class NavigateToResumePreviewState extends ResumeTempleteListState {
  final QuickResumeData resumeData;

  const NavigateToResumePreviewState(this.resumeData);

  @override
  List<Object> get props => [resumeData];
}

class NavigateToEditResumeState extends ResumeTempleteListState {
  final QuickResumeData resumeData;

  const NavigateToEditResumeState(this.resumeData);

  @override
  List<Object> get props => [resumeData];
}
