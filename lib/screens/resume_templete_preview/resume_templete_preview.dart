import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:html' as html;
import 'dart:html';

import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/models/skill.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template1.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template10.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template2.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template3.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template4.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template5.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template6.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template7.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template8.dart';
import 'package:quick_resume_creator/screens/resume_template/resume_template9.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_bloc.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_event.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_state.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:toastification/toastification.dart';

class ResumeTempletePreview extends StatefulWidget {
  final dynamic extra;
  final bool isstart;
  const ResumeTempletePreview({super.key, this.extra, required this.isstart});

  @override
  State<ResumeTempletePreview> createState() => _ResumeTempletePreviewState();
}

class _ResumeTempletePreviewState extends State<ResumeTempletePreview> {
  late ScrollController scrollController;
  bool _isDownloading = false;

  String resumeIndex = "";
  Map<String, dynamic> resumeData = {};

  @override
  void initState() {
    context
        .read<ResumeTemplatePreviewBloc>()
        .add(InitialLoadEvent(extra: widget.extra, isStart: widget.isstart));

    context.read<ResumeTemplatePreviewBloc>().add(LoadResumeData());

    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset >= 50) {
          showBackToTopButton = true;
        } else {
          showBackToTopButton = false;
        }
      });
    });

    super.initState();
  }

  void _startDownload() {
    setState(() {
      _isDownloading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isDownloading = false;
      });
    });
  }

  late var _isHovering = false;

  void _mouseEnter4(bool? isHover) {
    setState(() {
      _isHovering = isHover!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
        scrollController: scrollController,
        appBar: _buildappbar(),
        body: Column(
          children: [
            Divider(color: AppColors.dividercolor, height: 1),
            buildSizedBoxH(50),
            BlocBuilder<ResumeTemplatePreviewBloc, ResumeTemplatePreviewState>(
              builder: (context, state) {
                if (state is ResumeTemplatePreviewLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ResumeTemplatePreviewLoaded) {
                  window.localStorage['RESUMEID'] =
                      state.resumeData["id"].toString();
                  window.localStorage['CUSTOMERFIRSTNAME'] =
                      state.resumeData['customerFirstNametext'].toString();
                  window.localStorage['CUSTOMERLASTNAME'] =
                      state.resumeData['customerLastNametext'].toString();
                  window.localStorage['CUSTOMERPROFILEIMAGE'] =
                      state.resumeData['customerProfileImage'].toString();
                  window.localStorage['CUSTOMERPROFESSION'] =
                      state.resumeData['customerProfessiontext'].toString();
                  window.localStorage['CUSTOMERLOCATION'] =
                      state.resumeData['customerLocationtext'].toString();
                  window.localStorage['CUSTOMERWEBSITE'] =
                      state.resumeData['customerWebsitetext'].toString();
                  window.localStorage['CUSTOMERPHONENO'] =
                      state.resumeData['customerPhoneNotext'].toString();
                  window.localStorage['CUSTOMEREMAILID'] =
                      state.resumeData['customerEmailIDtext'].toString();
                  window.localStorage['CUSTOMERPROFESSIONALSUMMARY'] = state
                      .resumeData['customerProfessionalSummarytext']
                      .toString();
                  window.localStorage['CUSTOMEREDUCATIONLIST'] =
                      jsonEncode(state.resumeData['customerEducationList']);
                  window.localStorage['CUSTOMEREMPLOYMENTLIST'] =
                      jsonEncode(state.resumeData['customerEmploymentList']);
                  window.localStorage['CUSTOMERPROFESSIONALSKILLLIST'] =
                      jsonEncode(
                          state.resumeData['customerProfessionalSkillList']);
                  window.localStorage['CUSTOMERPERSONALSKILLLIST'] =
                      jsonEncode(state.resumeData['customerPersonalSkillList']);
                  window.localStorage['CUSTOMERSKILLLIST'] =
                      jsonEncode(state.resumeData['customerSkillList']);

                  resumeData = state.resumeData;

                  resumeIndex = window.localStorage['RESUMEID'] != null &&
                          window.localStorage['RESUMEID'] != ""
                      ? window.localStorage['RESUMEID'].toString()
                      : "1";
                } else if (state is ResumeTemplatePreviewError) {
                  return Center(child: Text(state.message));
                }
                return Column(
                  children: [
                    getResumeTemplate(resumeIndex),
                    buildSizedBoxH(100),
                    buildResumeDownloadButton(resumeData),
                    buildSizedBoxH(40),
                  ],
                );
              },
            ),
          ],
        ));
  }

  PreferredSizeWidget _buildappbar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width <= kScreenWidthSm
                  ? kDefaultPadding
                  : kDefaultPadding * 2,
              vertical: kDefaultPadding / 1.1),
          decoration: BoxDecoration(
            color: AppColors.white_color,
            boxShadow: showBackToTopButton
                ? [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: AppColors.text_color_black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: AppText(
            text: "My Resume",
            fontsize: 28,
            color: AppColors.text_color_black,
          ),
        ));
  }

  Widget buildResumeDownloadButton(Map<String, dynamic> resumeData) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocListener<ResumeTemplatePreviewBloc, ResumeTemplatePreviewState>(
          listener: (context, state) {
            if (state is ResumeDownloading) {
              _startDownload();
            } else if (state is ResumeDownloaded) {
              toastification.show(
                type: ToastificationType.success,
                showProgressBar: true,
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                animationDuration: const Duration(milliseconds: 300),
                title: const AppText(text: "Resume Downloaded."),
              );
            } else if (state is ResumeDownloadError) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    message: "Resume Downlod Failed.",
                    positiveButtonText: 'Ok',
                    onpositivePressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
          },
          child: MouseRegion(
            onEnter: (event) => _mouseEnter4(true),
            onExit: (event) => _mouseEnter4(false),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                context
                    .read<ResumeTemplatePreviewBloc>()
                    .add(DownloadResume(resumeIndex, resumeData));
              },
              child: AnimatedContainer(
                height: 80,
                decoration: BoxDecoration(
                  color: _isHovering
                      ? AppColors.primaryColor
                      : AppColors.text_color_black,
                  borderRadius: BorderRadius.circular(kDefaultPadding * 3),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 250),
                child: _isDownloading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 2.5),
                        child: Row(
                          children: [
                            AppText(
                              text: 'Downloading...',
                              color: AppColors.white_color,
                              fontsize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 40, right: 15),
                        child: Row(
                          children: [
                            AppText(
                              text: 'Download',
                              color: AppColors.white_color,
                              fontsize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                            buildSizedBoxW(26),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 45),
                              decoration: BoxDecoration(
                                color: AppColors.white_color,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: AppText(
                                  text: 'PDF',
                                  color: AppColors.text_color_black,
                                  fontsize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getResumeTemplate(String status) {
    switch (status) {
      case '1':
        return ResumeTemplate1(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              window.localStorage['CUSTOMEREDUCATIONLIST'] != null
                  ? (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                          as List<dynamic>)
                      .map<Education>((item) => Education.fromJson(item))
                      .toList()
                  : [],
          customerEmploymentList:
              window.localStorage['CUSTOMEREMPLOYMENTLIST'] != null
                  ? (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                          as List<dynamic>)
                      .map<Employment>((item) => Employment.fromJson(item))
                      .toList()
                  : [],
          customerProfessionalSkillList: window
                      .localStorage['CUSTOMERPROFESSIONALSKILLLIST'] !=
                  null
              ? (jsonDecode(
                          window.localStorage['CUSTOMERPROFESSIONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<ProfessionalSkill>(
                      (item) => ProfessionalSkill.fromJson(item))
                  .toList()
              : [],
          customerPersonalSkillList: window
                      .localStorage['CUSTOMERPERSONALSKILLLIST'] !=
                  null
              ? (jsonDecode(window.localStorage['CUSTOMERPERSONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<PersonalSkill>((item) => PersonalSkill.fromJson(item))
                  .toList()
              : [],
        );
      case '2':
        return ResumeTemplate2(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '3':
        return ResumeTemplate3(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '4':
        return ResumeTemplate4(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '5':
        return ResumeTemplate5(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '6':
        return ResumeTemplate6(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '7':
        return ResumeTemplate7(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerProfessionalSkillList:
              (jsonDecode(window.localStorage['CUSTOMERPROFESSIONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<ProfessionalSkill>(
                      (item) => ProfessionalSkill.fromJson(item))
                  .toList(),
          customerPersonalSkillList:
              (jsonDecode(window.localStorage['CUSTOMERPERSONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<PersonalSkill>((item) => PersonalSkill.fromJson(item))
                  .toList(),
        );
      case '8':
        return ResumeTemplate8(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '9':
        return ResumeTemplate9(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      case '10':
        return ResumeTemplate10(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                      as List<dynamic>)
                  .map<Education>((item) => Education.fromJson(item))
                  .toList(),
          customerEmploymentList:
              (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                      as List<dynamic>)
                  .map<Employment>((item) => Employment.fromJson(item))
                  .toList(),
          customerSkillList:
              (jsonDecode(window.localStorage['CUSTOMERSKILLLIST']!)
                      as List<dynamic>)
                  .map<Skill>((item) => Skill.fromJson(item))
                  .toList(),
        );
      default:
        return ResumeTemplate1(
          customerFirstNametext:
              window.localStorage['CUSTOMERFIRSTNAME'].toString(),
          customerLastNametext:
              window.localStorage['CUSTOMERLASTNAME'].toString(),
          customerProfileImageURL:
              html.window.localStorage['CUSTOMERPROFILEIMAGE'].toString(),
          customerProfessiontext:
              window.localStorage['CUSTOMERPROFESSION'].toString(),
          customerLocationtext:
              window.localStorage['CUSTOMERLOCATION'].toString(),
          customerWebsitetext:
              window.localStorage['CUSTOMERWEBSITE'].toString(),
          customerPhoneNotext:
              window.localStorage['CUSTOMERPHONENO'].toString(),
          customerEmailIDtext:
              window.localStorage['CUSTOMEREMAILID'].toString(),
          customerProfessionalSummarytext:
              window.localStorage['CUSTOMERPROFESSIONALSUMMARY'].toString(),
          customerEducationList:
              window.localStorage['CUSTOMEREDUCATIONLIST'] != null
                  ? (jsonDecode(window.localStorage['CUSTOMEREDUCATIONLIST']!)
                          as List<dynamic>)
                      .map<Education>((item) => Education.fromJson(item))
                      .toList()
                  : [],
          customerEmploymentList:
              window.localStorage['CUSTOMEREMPLOYMENTLIST'] != null
                  ? (jsonDecode(window.localStorage['CUSTOMEREMPLOYMENTLIST']!)
                          as List<dynamic>)
                      .map<Employment>((item) => Employment.fromJson(item))
                      .toList()
                  : [],
          customerProfessionalSkillList: window
                      .localStorage['CUSTOMERPROFESSIONALSKILLLIST'] !=
                  null
              ? (jsonDecode(
                          window.localStorage['CUSTOMERPROFESSIONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<ProfessionalSkill>(
                      (item) => ProfessionalSkill.fromJson(item))
                  .toList()
              : [],
          customerPersonalSkillList: window
                      .localStorage['CUSTOMERPERSONALSKILLLIST'] !=
                  null
              ? (jsonDecode(window.localStorage['CUSTOMERPERSONALSKILLLIST']!)
                      as List<dynamic>)
                  .map<PersonalSkill>((item) => PersonalSkill.fromJson(item))
                  .toList()
              : [],
        );
    }
  }
}
