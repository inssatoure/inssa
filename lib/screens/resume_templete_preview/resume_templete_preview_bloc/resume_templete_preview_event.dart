import 'package:equatable/equatable.dart';

abstract class ResumeTemplatePreviewEvent extends Equatable {
  const ResumeTemplatePreviewEvent();

  @override
  List<Object> get props => [];
}

class InitialLoadEvent extends ResumeTemplatePreviewEvent {
  final dynamic extra;
  final bool isStart;

  const InitialLoadEvent({required this.extra, required this.isStart});

  @override
  List<Object> get props => [extra, isStart];
}

class LoadResumeData extends ResumeTemplatePreviewEvent {}

class DownloadResume extends ResumeTemplatePreviewEvent {
  final String resumeIndex;
  final Map<String, dynamic> resumeData;

  const DownloadResume(this.resumeIndex, this.resumeData);

  @override
  List<Object> get props => [resumeIndex, resumeData];
}
