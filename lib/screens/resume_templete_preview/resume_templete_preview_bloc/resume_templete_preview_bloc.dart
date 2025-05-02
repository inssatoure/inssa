import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete1.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete10.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete2.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete3.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete4.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete5.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete6.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete7.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete8.dart';
import 'package:quick_resume_creator/screens/pdf_resume/pdf_resume_templete9.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_event.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_state.dart';

class ResumeTemplatePreviewBloc
    extends Bloc<ResumeTemplatePreviewEvent, ResumeTemplatePreviewState> {
  ResumeTemplatePreviewBloc()
      : super(const ResumeTemplatePreviewInitial(extra: null, isStart: true)) {
    on<InitialLoadEvent>(_onInitialLoad);
    on<LoadResumeData>(_onLoadResumeData);
    on<DownloadResume>(_onDownloadResume);
  }

  void _onInitialLoad(
      InitialLoadEvent event, Emitter<ResumeTemplatePreviewState> emit) {
    emit(ResumeTemplatePreviewInitial(
        extra: event.extra, isStart: event.isStart));

    add(LoadResumeData());
  }

  void _onLoadResumeData(
      LoadResumeData event, Emitter<ResumeTemplatePreviewState> emit) async {
    emit(ResumeTemplatePreviewLoading());
    try {
      String jsonString = window.localStorage['RESUMEDATA']!;

      if (jsonString.startsWith('"') && jsonString.endsWith('"')) {
        jsonString = jsonString
            .substring(1, jsonString.length - 1)
            .replaceAll('\\"', '"');
      }

      final Map<String, dynamic> resumeData = json.decode(jsonString);

      emit(ResumeTemplatePreviewLoaded(resumeData));
    } catch (e) {
      log(e.toString());
      emit(ResumeTemplatePreviewError(e.toString()));
    }
  }

  void _onDownloadResume(
      DownloadResume event, Emitter<ResumeTemplatePreviewState> emit) async {
    emit(ResumeDownloading());

    try {
      if (kIsWeb) {
        _downloadPdf(event.resumeIndex, event.resumeData);
      }

      emit(ResumeDownloaded());
    } catch (e) {
      log(e.toString());
      emit(ResumeDownloadError(e.toString()));
    }
  }

  Future<void> _downloadPdf(
      String resumeIndex, Map<String, dynamic> resumeData) async {
    switch (resumeIndex) {
      case "1":
        pdfResumeTemplete1(resumeData);
        break;
      case "2":
        pdfResumeTemplete2(resumeData);
        break;
      case "3":
        pdfResumeTemplete3(resumeData);
        break;
      case "4":
        pdfResumeTemplete4(resumeData);
        break;
      case "5":
        pdfResumeTemplete5(resumeData);
        break;
      case "6":
        pdfResumeTemplete6(resumeData);
        break;
      case "7":
        pdfResumeTemplete7(resumeData);
        break;
      case "8":
        pdfResumeTemplete8(resumeData);
        break;
      case "9":
        pdfResumeTemplete9(resumeData);
        break;
      case "10":
        pdfResumeTemplete10(resumeData);
        break;
      default:
        pdfResumeTemplete1(resumeData);
    }
  }
}
