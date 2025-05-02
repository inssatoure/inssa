import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';
import 'package:quick_resume_creator/repository/quick_resume_creator_repository.dart';
import 'package:quick_resume_creator/screens/create_resume/create_resume_bloc/create_resume_even.dart';
import 'create_resume_state.dart';

class CreateResumeBloc extends Bloc<CreateResumeEvent, CreateResumeState> {
  final QuickResumeRepository quickResumeRepository;
  CreateResumeBloc({required this.quickResumeRepository})
      : super(CreateResumeFaild()) {
    on<CreateResumeRequested>(_onCreateResumeRequested);
  }

  Future<void> _onCreateResumeRequested(
      CreateResumeRequested event, Emitter<CreateResumeState> emit) async {
    emit(CreateResumeLoading());

    try {
      final resumeData = QuickResumeData(
        uid: event.uid,
        id: event.id,
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
        updatedAt: event.updatedAt,
      );

      await quickResumeRepository.addQuickResumeData(
          resumeData, event.customerProfileImage);

      emit(CreateResumeSuccess());
    } catch (error) {
      emit(CreateResumeError(error.toString()));
      emit(CreateResumeFaild());
    }
  }
}
