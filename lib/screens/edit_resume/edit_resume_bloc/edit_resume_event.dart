// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/models/skill.dart';

abstract class EditResumeEvent extends Equatable {
  const EditResumeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEditData extends EditResumeEvent {
  const LoadEditData();

  @override
  List<Object?> get props => [];
}

class InitialEditResumeDataLoadEvent extends EditResumeEvent {
  final dynamic extra;
  final bool isStart;

  const InitialEditResumeDataLoadEvent(
      {required this.extra, required this.isStart});

  @override
  List<Object> get props => [extra, isStart];
}

class UpdateResumeRequested extends EditResumeEvent {
  final String uid;
  final String id;
  final String? resumeid;
  final Uint8List? customerProfileImage;
  final String customerProfileImageURL;
  final String customerFirstNametext;
  final String customerLastNametext;
  final String customerProfessiontext;
  final String customerLocationtext;
  final String customerWebsitetext;
  final String customerPhoneNotext;
  final String customerEmailIDtext;
  final String customerProfessionalSummarytext;
  final String customerUniversitytext;
  final String customerDegreetext;
  final String customerStartDatetext;
  final String customerEndDatetext;
  final String customerJobTitletext;
  final String customerCompanyNametext;
  final String customerEmploymentStartDatetext;
  final String customerEmploymentEndDatetext;
  final String customerEmploymentAddresstext;
  final String customerSkilltext;
  final String customerProfessionalSkilltext;
  final String customerPersonalSkilltext;
  final double customerSkillLevel;
  final String? createdAt;
  final String? updatedAt;
  List<Education> customerEducationList = [];
  List<Employment> customerEmploymentList = [];
  List<ProfessionalSkill> customerProfessionalSkillList = [];
  List<PersonalSkill> customerPersonalSkillList = [];
  List<Skill> customerSkillList = [];

  UpdateResumeRequested({
    required this.uid,
    required this.id,
    this.resumeid,
    this.customerProfileImage,
    required this.customerProfileImageURL,
    required this.customerFirstNametext,
    required this.customerLastNametext,
    required this.customerProfessiontext,
    required this.customerLocationtext,
    required this.customerWebsitetext,
    required this.customerPhoneNotext,
    required this.customerEmailIDtext,
    required this.customerProfessionalSummarytext,
    required this.customerUniversitytext,
    required this.customerDegreetext,
    required this.customerStartDatetext,
    required this.customerEndDatetext,
    required this.customerJobTitletext,
    required this.customerCompanyNametext,
    required this.customerEmploymentStartDatetext,
    required this.customerEmploymentEndDatetext,
    required this.customerEmploymentAddresstext,
    required this.customerSkilltext,
    required this.customerProfessionalSkilltext,
    required this.customerPersonalSkilltext,
    required this.customerSkillLevel,
    required this.customerEducationList,
    required this.customerEmploymentList,
    required this.customerProfessionalSkillList,
    required this.customerPersonalSkillList,
    required this.customerSkillList,
    this.createdAt,
    this.updatedAt,
  });
}
