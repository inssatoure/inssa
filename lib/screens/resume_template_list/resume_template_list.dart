import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/models/quick_resume_data.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list1.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list10.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list2.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list3.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list4.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list5.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list6.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list7.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list8.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template/resume_templates_list9.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_bloc.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_event.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_state.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';

class ResumeTemplateList extends StatefulWidget {
  const ResumeTemplateList({super.key});

  @override
  State<ResumeTemplateList> createState() => _ResumeTemplateListState();
}

class _ResumeTemplateListState extends State<ResumeTemplateList> {
  bool showBgColor = false;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();

    context.read<ResumeTempleteListBloc>().add(LoadResumes());
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final summaryCardCrossAxisCount = (size.width >= kScreenWidthXxxl2
        ? 5
        : size.width >= kScreenWidthXxl
            ? 4
            : size.width >= kScreenWidthLg2
                ? 3
                : size.width >= kScreenWidthMd
                    ? 2
                    : 1);

    return PortalMasterLayout(
      backgroundColor: showBgColor ? AppColors.white_color : Colors.transparent,
      scrollController: scrollController,
      appBar: _buildappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: AppColors.dividercolor, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
            child: _gridview(summaryCardCrossAxisCount),
          ),
        ],
      ),
    );
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

  Widget _gridview(int summaryCardCrossAxisCount) {
    return BlocBuilder<ResumeTempleteListBloc, ResumeTempleteListState>(
        builder: (context, state) {
      List<QuickResumeData> resumeDataList =
          state is ResumeTempleteListLoaded ? state.resumes : [];

      if (state is ResumeTempleteListLoading) {
        showBgColor = false;
      } else if (state is ResumeTempleteListLoaded && state.resumes.isEmpty) {
        showBgColor = true;
      } else if (state is ResumeTempleteListLoaded) {
        showBgColor = true;
      } else if (state is ResumeTempleteListError) {
        showBgColor = false;
      }

      Future.delayed(const Duration(seconds: 0), () {
        setState(() {});
      });

      return state is ResumeTempleteListLoaded && state.resumes.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: MediaQuery.of(context).size.height / 2.5,
                ),
                child: const AppText(text: "No Resume Found."),
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                resumeDataList.sort((a, b) {
                  final dateA = DateTime.parse(a.updatedAt ?? '');
                  final dateB = DateTime.parse(b.updatedAt ?? '');

                  return dateB.compareTo(dateA);
                });
                final summaryCardWidth = ((constraints.maxWidth -
                            (kDefaultPadding *
                                (summaryCardCrossAxisCount - 1))) /
                        summaryCardCrossAxisCount -
                    kTextPadding +
                    1);

                return Wrap(
                  direction: Axis.horizontal,
                  spacing: kDefaultPadding * 1.2,
                  runSpacing: kDefaultPadding * 1.2,
                  children: List.generate(resumeDataList.length, (index) {
                    return BlocListener<ResumeTempleteListBloc,
                        ResumeTempleteListState>(
                      listener: (context, state) {
                        if (state is NavigateToResumePreviewState) {
                          GoRouter.of(context).go(RouteUri.resumepreview,
                              extra: state.resumeData);
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          context.read<ResumeTempleteListBloc>().add(
                                NavigateToResumePreview(resumeDataList[index]),
                              );
                        },
                        child: Container(
                          width: summaryCardWidth,
                          padding: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                            color: AppColors.lightorengecolor.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding),
                          ),
                          child: Column(
                            children: [
                              getInvoiceById(resumeDataList[index]),
                              buildSizedBoxH(kDefaultPadding),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text:
                                          "${resumeDataList[index].customerFirstNametext} ${resumeDataList[index].customerLastNametext}",
                                      fontsize: 20,
                                      color: AppColors.text_color_black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  buildSizedBoxW(kDefaultPadding),
                                  _buildpopupbutton(
                                      resumeDataList[index], false)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            );
    });
  }

  Widget getInvoiceById(QuickResumeData resumeDataList) {
    switch (resumeDataList.id) {
      case '1':
        return ResumeTemplatesList1(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerProfessionalSkillList:
              resumeDataList.customerProfessionalSkillList,
          customerPersonalSkillList: resumeDataList.customerPersonalSkillList,
        );
      case '2':
        return ResumeTemplatesList2(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '3':
        return ResumeTemplatesList3(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '4':
        return ResumeTemplatesList4(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '5':
        return ResumeTemplatesList5(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '6':
        return ResumeTemplatesList6(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '7':
        return ResumeTemplatesList7(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerProfessionalSkillList:
              resumeDataList.customerProfessionalSkillList,
          customerPersonalSkillList: resumeDataList.customerPersonalSkillList,
        );
      case '8':
        return ResumeTemplatesList8(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '9':
        return ResumeTemplatesList9(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      case '10':
        return ResumeTemplatesList10(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerSkillList: resumeDataList.customerSkillList,
        );
      default:
        return ResumeTemplatesList1(
          customerFirstNametext: resumeDataList.customerFirstNametext,
          customerLastNametext: resumeDataList.customerLastNametext,
          customerProfileImageURL: resumeDataList.customerProfileImage,
          customerProfessiontext: resumeDataList.customerProfessiontext,
          customerLocationtext: resumeDataList.customerLocationtext,
          customerWebsitetext: resumeDataList.customerWebsitetext,
          customerPhoneNotext: resumeDataList.customerPhoneNotext,
          customerEmailIDtext: resumeDataList.customerEmailIDtext,
          customerProfessionalSummarytext:
              resumeDataList.customerProfessionalSummarytext,
          customerEducationList: resumeDataList.customerEducationList,
          customerEmploymentList: resumeDataList.customerEmploymentList,
          customerProfessionalSkillList:
              resumeDataList.customerProfessionalSkillList,
          customerPersonalSkillList: resumeDataList.customerPersonalSkillList,
        );
    }
  }

  Widget _buildpopupbutton(QuickResumeData resumeDataList, bool isPaid) {
    return PopupMenuButton(
      color: AppColors.white_color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            onTap: () {
              context
                  .read<ResumeTempleteListBloc>()
                  .add(NavigateToEditResume(resumeDataList));
            },
            value: 'Option 1',
            child:
                BlocListener<ResumeTempleteListBloc, ResumeTempleteListState>(
              listener: (context, state) {
                if (state is NavigateToEditResumeState) {
                  GoRouter.of(context).pushReplacementNamed(RouteUri.editResume,
                      extra: jsonEncode(resumeDataList));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding - kTextPadding),
                child: Row(
                  children: [
                    Image.asset('${AppImages.ic}ic_edit.png',
                        height: 20, fit: BoxFit.cover),
                    buildSizedBoxW(25),
                    Text(
                      'Edit',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'Option 3',
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding - kTextPadding),
              child: Row(
                children: [
                  Image.asset('${AppImages.ic}ic_delete.png',
                      height: 20, fit: BoxFit.cover),
                  buildSizedBoxW(25),
                  Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
            onTap: () {
              _showDeleteConfirmationDialog(resumeDataList.resumeid);
            },
          ),
        ];
      },
      offset: const Offset(0, 50),
      child: Row(
        children: [
          Icon(Icons.more_vert_rounded,
              color: AppColors.text_color_black, size: 25),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(String? resumeid) async {
    return showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return CustomDialog(
          imagePath: "${AppImages.pngImage}img_dailog_heder.png",
          message: "Are you sure you want to delete this resume?",
          positiveButtonText: 'Yes',
          negativeButtonText: 'Cancel',
          onpositivePressed: () {
            context
                .read<ResumeTempleteListBloc>()
                .add(DeleteResume(resumeid ?? '1'));
            Future.delayed(const Duration(milliseconds: 2),
                () => Navigator.of(context).pop());
          },
        );
      },
    );
  }
}
