import 'dart:convert';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';
import 'package:quick_resume_creator/repository/quick_resume_creator_repository.dart';
import 'edit_resume_event.dart';
import 'edit_resume_state.dart';

class EditResumeBloc extends Bloc<EditResumeEvent, EditResumeState> {
  final QuickResumeRepository? quickResumeRepository;
  EditResumeBloc({this.quickResumeRepository}) : super(EditResumeInitial()) {
    on<InitialEditResumeDataLoadEvent>(_onInitialEditResumeDataLoad);
    on<LoadEditData>(_onLoadEditData);
    on<UpdateResumeRequested>(_onUpdateResumeRequested);
  }

  void _onInitialEditResumeDataLoad(
      InitialEditResumeDataLoadEvent event, Emitter<EditResumeState> emit) {
    emit(EditResumeTemplateInitial(extra: event.extra, isStart: event.isStart));

    add(const LoadEditData());
  }

  void _onLoadEditData(LoadEditData event, Emitter<EditResumeState> emit) {
    try {
      emit(EditResumeLoading());

      String jsonstring = json.decode(window.localStorage['EDITDATA']!);
      Map<String, dynamic> resumeData = json.decode(jsonstring);

      emit(EditResumeLoaded(resumeData));
    } catch (e) {
      emit(EditResumeError(e.toString()));
    }
  }

  Future<void> _onUpdateResumeRequested(
      UpdateResumeRequested event, Emitter<EditResumeState> emit) async {
    emit(UpdateResumeLoading());

    try {
      final resumeData = QuickResumeData(
        uid: event.uid,
        id: event.id,
        resumeid: event.resumeid,
        customerFirstNametext: event.customerFirstNametext,
        customerLastNametext: event.customerLastNametext,
        customerProfileImage: event.customerProfileImageURL,
        customerProfessiontext: event.customerProfessiontext,
        customerLocationtext: event.customerLocationtext,
        customerWebsitetext: event.customerWebsitetext,
        customerPhoneNotext: event.customerPhoneNotext,
        customerEmailIDtext: event.customerEmailIDtext,
        customerProfessionalSummarytext: event.customerProfessionalSummarytext,
        customerEducationList: event.customerEducationList,
        customerEmploymentList: event.customerEmploymentList,
        customerProfessionalSkillList: event.customerProfessionalSkillList,
        customerPersonalSkillList: event.customerPersonalSkillList,
        customerSkillList: event.customerSkillList,
        customerSkillLevel: event.customerSkillLevel,
        createdAt: event.createdAt,
        updatedAt: DateTime.now().toString(),
      );

      await quickResumeRepository!.updateResume(event.resumeid!, resumeData);

      emit(UpdateResumeSuccess());
    } catch (error) {
      emit(UpdateResumeError(error.toString()));
      emit(UpdateResumeFaild());
    }
  }
}
