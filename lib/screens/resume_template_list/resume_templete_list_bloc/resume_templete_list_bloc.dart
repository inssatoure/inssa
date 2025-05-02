import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_event.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';

class ResumeTempleteListBloc
    extends Bloc<ResumeTempleteListEvent, ResumeTempleteListState> {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ResumeTempleteListBloc(this._auth, this._firestore)
      : super(ResumeTempleteListInitial()) {
    on<LoadResumes>(_onLoadResumes);
    on<DeleteResume>(_onDeleteResume);
    on<NavigateToResumePreview>(_onNavigateToResumePreview);
    on<NavigateToEditResume>(_onNavigateToEditResume);
  }

  void _onLoadResumes(
      LoadResumes event, Emitter<ResumeTempleteListState> emit) async {
    emit(ResumeTempleteListLoading());
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(const ResumeTempleteListError('No user logged in'));
        return;
      }

      var snapshot = await _firestore
          .collection('resume_data')
          .doc(currentUser.uid)
          .collection('user_resume')
          .get();

      List<QuickResumeData> resumeDataList = snapshot.docs.map((doc) {
        var data = doc.data();
        return QuickResumeData.fromMap(data);
      }).toList();

      emit(ResumeTempleteListLoaded(resumeDataList));
    } catch (e) {
      emit(ResumeTempleteListError(e.toString()));
    }
  }

  void _onDeleteResume(
      DeleteResume event, Emitter<ResumeTempleteListState> emit) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(const ResumeTempleteListError('No user logged in'));
        return;
      }

      await _firestore
          .collection('resume_data')
          .doc(currentUser.uid)
          .collection('user_resume')
          .doc(event.resumeId)
          .delete();

      add(LoadResumes());
      emit(ResumeDeleted());
    } catch (e) {
      emit(ResumeError(e.toString()));
    }
  }

  void _onNavigateToResumePreview(NavigateToResumePreview event,
      Emitter<ResumeTempleteListState> emit) async {
    log('PREVIEW SCREEN');
    window.localStorage['RESUMEDATA'] = json.encode(event.resumeData);

    emit(NavigateToResumePreviewState(event.resumeData));
  }

  void _onNavigateToEditResume(
      NavigateToEditResume event, Emitter<ResumeTempleteListState> emit) async {
    log('EDIT RESUME SCREEN');
    window.localStorage['EDITDATA'] = json.encode(event.resumeData);

    emit(NavigateToEditResumeState(event.resumeData));
  }
}
