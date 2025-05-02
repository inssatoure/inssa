import 'package:equatable/equatable.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';

abstract class ResumeTempleteListEvent extends Equatable {
  const ResumeTempleteListEvent();

  @override
  List<Object> get props => [];
}

class LoadResumes extends ResumeTempleteListEvent {}

class DeleteResume extends ResumeTempleteListEvent {
  final String resumeId;

  const DeleteResume(this.resumeId);

  @override
  List<Object> get props => [resumeId];
}

class NavigateToResumePreview extends ResumeTempleteListEvent {
  final QuickResumeData resumeData;

  const NavigateToResumePreview(this.resumeData);

  @override
  List<Object> get props => [resumeData];
}

class NavigateToEditResume extends ResumeTempleteListEvent {
  final QuickResumeData resumeData;

  const NavigateToEditResume(this.resumeData);

  @override
  List<Object> get props => [resumeData];
}
