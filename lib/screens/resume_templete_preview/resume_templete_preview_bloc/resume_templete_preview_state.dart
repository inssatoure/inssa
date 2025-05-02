import 'package:equatable/equatable.dart';

abstract class ResumeTemplatePreviewState extends Equatable {
  const ResumeTemplatePreviewState();

  @override
  List<Object> get props => [];
}

class ResumeTemplatePreviewInitial extends ResumeTemplatePreviewState {
  final dynamic extra;
  final bool isStart;

  const ResumeTemplatePreviewInitial(
      {required this.extra, required this.isStart});

  @override
  List<Object> get props => [extra, isStart];
}

class ResumeTemplatePreviewLoading extends ResumeTemplatePreviewState {}

class ResumeTemplatePreviewLoaded extends ResumeTemplatePreviewState {
  final Map<String, dynamic> resumeData;

  const ResumeTemplatePreviewLoaded(this.resumeData);

  @override
  List<Object> get props => [resumeData];
}

class ResumeTemplatePreviewError extends ResumeTemplatePreviewState {
  final String message;

  const ResumeTemplatePreviewError(this.message);

  @override
  List<Object> get props => [message];
}

class ResumeDownloading extends ResumeTemplatePreviewState {}

class ResumeDownloaded extends ResumeTemplatePreviewState {}

class ResumeDownloadError extends ResumeTemplatePreviewState {
  final String message;

  const ResumeDownloadError(this.message);

  @override
  List<Object> get props => [message];
}
