import 'dart:convert';

import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/models/skill.dart';

class QuickResumeData {
  final String? uid;
  final String? id;
  final String? resumeid;
  final String? customerFirstNametext;
  final String? customerLastNametext;
  final String? customerProfileImage;
  final String? customerProfessiontext;
  final String? customerLocationtext;
  final String? customerWebsitetext;
  final String? customerPhoneNotext;
  final String? customerEmailIDtext;
  final String? customerProfessionalSummarytext;
  final List<Education>? customerEducationList;
  final List<Employment>? customerEmploymentList;
  final List<ProfessionalSkill>? customerProfessionalSkillList;
  final List<PersonalSkill>? customerPersonalSkillList;
  final List<Skill>? customerSkillList;
  final double? customerSkillLevel;
  final String? createdAt;
  final String? updatedAt;

  QuickResumeData({
    required this.uid,
    required this.id,
    this.resumeid,
    required this.customerFirstNametext,
    required this.customerLastNametext,
    required this.customerProfileImage,
    required this.customerProfessiontext,
    required this.customerLocationtext,
    required this.customerWebsitetext,
    required this.customerPhoneNotext,
    required this.customerEmailIDtext,
    required this.customerProfessionalSummarytext,
    required this.customerEducationList,
    required this.customerEmploymentList,
    required this.customerProfessionalSkillList,
    required this.customerPersonalSkillList,
    required this.customerSkillList,
    required this.customerSkillLevel,
    this.createdAt,
    this.updatedAt,
  });

  QuickResumeData copyWith({
    String? uid,
    String? id,
    String? resumeid,
    String? customerFirstNametext,
    String? customerLastNametext,
    String? customerProfileImage,
    String? customerProfessiontext,
    String? customerLocationtext,
    String? customerWebsitetext,
    String? customerPhoneNotext,
    String? customerEmailIDtext,
    String? customerProfessionalSummarytext,
    List<Education>? customerEducationList,
    List<Employment>? customerEmploymentList,
    List<ProfessionalSkill>? customerProfessionalSkillList,
    List<PersonalSkill>? customerPersonalSkillList,
    List<Skill>? customerSkillList,
    double? customerSkillLevel,
    String? createdAt,
    String? updatedAt,
  }) {
    return QuickResumeData(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      resumeid: resumeid ?? this.resumeid,
      customerFirstNametext:
          customerFirstNametext ?? this.customerFirstNametext,
      customerLastNametext: customerLastNametext ?? this.customerLastNametext,
      customerProfileImage: customerProfileImage ?? this.customerProfileImage,
      customerProfessiontext:
          customerProfessiontext ?? this.customerProfessiontext,
      customerLocationtext: customerLocationtext ?? this.customerLocationtext,
      customerWebsitetext: customerWebsitetext ?? this.customerWebsitetext,
      customerPhoneNotext: customerPhoneNotext ?? this.customerPhoneNotext,
      customerEmailIDtext: customerEmailIDtext ?? this.customerEmailIDtext,
      customerProfessionalSummarytext: customerProfessionalSummarytext ??
          this.customerProfessionalSummarytext,
      customerEducationList:
          customerEducationList ?? this.customerEducationList,
      customerEmploymentList:
          customerEmploymentList ?? this.customerEmploymentList,
      customerProfessionalSkillList:
          customerProfessionalSkillList ?? this.customerProfessionalSkillList,
      customerPersonalSkillList:
          customerPersonalSkillList ?? this.customerPersonalSkillList,
      customerSkillList: customerSkillList ?? this.customerSkillList,
      customerSkillLevel: customerSkillLevel ?? this.customerSkillLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'resumeid': resumeid,
      'customerFirstNametext': customerFirstNametext,
      'customerLastNametext': customerLastNametext,
      'customerProfileImage': customerProfileImage,
      'customerProfessiontext': customerProfessiontext,
      'customerLocationtext': customerLocationtext,
      'customerWebsitetext': customerWebsitetext,
      'customerPhoneNotext': customerPhoneNotext,
      'customerEmailIDtext': customerEmailIDtext,
      'customerProfessionalSummarytext': customerProfessionalSummarytext,
      'customerEducationList':
          customerEducationList?.map((e) => e.toMap()).toList(),
      'customerEmploymentList':
          customerEmploymentList?.map((e) => e.toMap()).toList(),
      'customerProfessionalSkillList':
          customerProfessionalSkillList?.map((e) => e.toMap()).toList(),
      'customerPersonalSkillList':
          customerPersonalSkillList?.map((e) => e.toMap()).toList(),
      'customerSkillList': customerSkillList?.map((e) => e.toMap()).toList(),
      'customerSkillLevel': customerSkillLevel,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory QuickResumeData.fromMap(Map<String, dynamic> map) {
    return QuickResumeData(
      uid: map['uid'],
      id: map['id'],
      resumeid: map['resumeid'],
      customerFirstNametext: map['customerFirstNametext'],
      customerLastNametext: map['customerLastNametext'],
      customerProfileImage: map['customerProfileImage'],
      customerProfessiontext: map['customerProfessiontext'],
      customerLocationtext: map['customerLocationtext'],
      customerWebsitetext: map['customerWebsitetext'],
      customerPhoneNotext: map['customerPhoneNotext'],
      customerEmailIDtext: map['customerEmailIDtext'],
      customerProfessionalSummarytext: map['customerProfessionalSummarytext'],
      customerEducationList: map['customerEducationList'] != null
          ? List<Education>.from(
              map['customerEducationList']?.map((x) => Education.fromJson(x)))
          : null,
      customerEmploymentList: map['customerEmploymentList'] != null
          ? List<Employment>.from(
              map['customerEmploymentList']?.map((x) => Employment.fromJson(x)))
          : null,
      customerProfessionalSkillList: map['customerProfessionalSkillList'] !=
              null
          ? List<ProfessionalSkill>.from(map['customerProfessionalSkillList']
              ?.map((x) => ProfessionalSkill.fromJson(x)))
          : null,
      customerPersonalSkillList: map['customerPersonalSkillList'] != null
          ? List<PersonalSkill>.from(map['customerPersonalSkillList']
              ?.map((x) => PersonalSkill.fromJson(x)))
          : null,
      customerSkillList: map['customerSkillList'] != null
          ? List<Skill>.from(
              map['customerSkillList']?.map((x) => Skill.fromJson(x)))
          : null,
      customerSkillLevel: map['customerSkillLevel'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuickResumeData.fromJson(String source) =>
      QuickResumeData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QuickResumeData(uid: $uid, id: $id, resumeid: $resumeid, customerFirstNametext: $customerFirstNametext, customerLastNametext: $customerLastNametext, customerProfileImage: $customerProfileImage, customerProfessiontext: $customerProfessiontext, customerLocationtext: $customerLocationtext, customerWebsitetext: $customerWebsitetext, customerPhoneNotext: $customerPhoneNotext, customerEmailIDtext: $customerEmailIDtext, customerProfessionalSummarytext: $customerProfessionalSummarytext, customerEducationList: $customerEducationList, customerEmploymentList: $customerEmploymentList, customerProfessionalSkillList: $customerProfessionalSkillList, customerPersonalSkillList: $customerPersonalSkillList, customerSkillList: $customerSkillList, customerSkillLevel: $customerSkillLevel, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
