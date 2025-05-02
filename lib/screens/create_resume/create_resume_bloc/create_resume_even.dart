// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/models/skill.dart';

abstract class CreateResumeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateResumeRequested extends CreateResumeEvent {
  final String uid;
  final String id;
  final Uint8List customerProfileImage;
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

  CreateResumeRequested(
    this.uid,
    this.id,
    this.customerProfileImage,
    this.customerProfileImageURL,
    this.customerFirstNametext,
    this.customerLastNametext,
    this.customerProfessiontext,
    this.customerLocationtext,
    this.customerWebsitetext,
    this.customerPhoneNotext,
    this.customerEmailIDtext,
    this.customerProfessionalSummarytext,
    this.customerUniversitytext,
    this.customerDegreetext,
    this.customerStartDatetext,
    this.customerEndDatetext,
    this.customerJobTitletext,
    this.customerCompanyNametext,
    this.customerEmploymentStartDatetext,
    this.customerEmploymentEndDatetext,
    this.customerEmploymentAddresstext,
    this.customerSkilltext,
    this.customerProfessionalSkilltext,
    this.customerPersonalSkilltext,
    this.customerSkillLevel,
    this.customerEducationList,
    this.customerEmploymentList,
    this.customerProfessionalSkillList,
    this.customerPersonalSkillList,
    this.customerSkillList,
    this.createdAt,
    this.updatedAt,
  );
}
