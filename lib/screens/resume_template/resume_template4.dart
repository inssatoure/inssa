// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/skill.dart';
import 'package:quick_resume_creator/screens/create_resume/create_resume.dart';

class ResumeTemplate4 extends StatefulWidget {
  ResumeTemplate4({
    super.key,
    required this.customerFirstNametext,
    required this.customerLastNametext,
    this.customerProfileImage,
    required this.customerProfileImageURL,
    required this.customerProfessiontext,
    required this.customerLocationtext,
    required this.customerWebsitetext,
    required this.customerPhoneNotext,
    required this.customerEmailIDtext,
    required this.customerProfessionalSummarytext,
    required this.customerEducationList,
    required this.customerEmploymentList,
    required this.customerSkillList,
  });

  String? customerFirstNametext;
  String? customerLastNametext;
  Uint8List? customerProfileImage;
  String? customerProfileImageURL;
  String? customerProfessiontext;
  String? customerLocationtext;
  String? customerWebsitetext;
  String? customerPhoneNotext;
  String? customerEmailIDtext;
  String? customerProfessionalSummarytext;
  List<Education>? customerEducationList;
  List<Employment>? customerEmploymentList;
  List<Skill>? customerSkillList;

  @override
  State<ResumeTemplate4> createState() => _ResumeTemplate4State();
}

class _ResumeTemplate4State extends State<ResumeTemplate4> {
  @override
  Widget build(BuildContext context) {
    const summaryCardCrossAxisCount = 3;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? MediaQuery.of(context).size.height * 0.73
            : MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width * 1.27
                : 920,
        maxWidth: MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width
            : 709,
      ),
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildProfileAndUsername(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? MediaQuery.of(context).size.width / 38.4
                          : 20,
                  vertical: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 48
                      : kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOtherDetails(),
                  buildSizedBoxH(
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? MediaQuery.of(context).size.width / 192
                          : kTextPadding),
                  _buildEducation(),
                  _buildEmployment(),
                  _buildSkils(summaryCardCrossAxisCount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAndUsername() {
    return Container(
      width: double.infinity,
      color: AppColors.lightorengecolor,
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 109
                  : 7,
            ),
            height: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 8
                : 96,
            width: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 8
                : 96,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: AppColors.gray_color.withOpacity(0.2),
                shape: BoxShape.circle),
            child: widget.customerProfileImage != null
                ? Image.memory(
                    widget.customerProfileImage!,
                    fit: BoxFit.cover,
                  )
                : widget.customerProfileImageURL != null
                    ? CatchImageNetwork(
                        networkImageURL: widget.customerProfileImageURL!)
                    : Image.asset(
                        "assets/images/png/img_profile.png",
                        fit: BoxFit.cover,
                      ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
          Text(
            "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
            style: GoogleFonts.sourceSerif4(
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 109
                  : 28,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 192
              : kTextPadding),
          Text(
            widget.customerProfessiontext ?? "UI/UX Designer",
            style: GoogleFonts.hind(
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 54.85
                  : 14,
              color: AppColors.text_color_black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildProfile()),
            buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 48
                : kDefaultPadding),
            _buildContacts(),
          ],
        )
      ],
    );
  }

  Widget titleText(String titleText) {
    return Text(
      titleText,
      style: GoogleFonts.ibmPlexSans(
        fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 42.66
            : 18,
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget headingText(String headingText,
      [double? fontSize, Color? color, FontWeight? fontWeight]) {
    return Text(
      headingText,
      style: GoogleFonts.ibmPlexSans(
        fontSize: fontSize ??
            (MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 48
                : 16),
        color: color ?? AppColors.text_color_black,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }

  Widget titleSubText(String titleSubText,
      [double? fontSize, Color? color, TextStyle? style]) {
    return Text(
      titleSubText,
      style: style ??
          GoogleFonts.hind(
            fontSize: fontSize ??
                (MediaQuery.of(context).size.width <= kScreenWidthMd
                    ? MediaQuery.of(context).size.width / 54.85
                    : 14),
            color: color ?? AppColors.text_darkgrey_color,
          ),
    );
  }

  Widget _buildProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Profile"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        titleSubText(widget.customerProfessionalSummarytext ??
            "Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings."),
      ],
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Contacts"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        SizedBox(
          width: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 2.95
              : 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.customerPhoneNotext == ""
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _builsContactDataField(
                            "${AppImages.ic}ic_filled_call.png",
                            widget.customerPhoneNotext ?? "(914) 479-6342"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                      ],
                    ),
              widget.customerLocationtext == ""
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _builsContactDataField(
                            "${AppImages.ic}ic_filled_location.png",
                            widget.customerLocationtext ??
                                "2207 Apple Avenue, Los Angeles"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                      ],
                    ),
              widget.customerEmailIDtext == ""
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _builsContactDataField(
                            "${AppImages.ic}ic_filled_mail.png",
                            widget.customerEmailIDtext ??
                                "clifford@design.mail"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                      ],
                    ),
              widget.customerWebsitetext == ""
                  ? const SizedBox.shrink()
                  : _builsContactDataField(
                      "${AppImages.ic}ic_filled_network.png",
                      widget.customerWebsitetext ?? "www.clifford.design"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _builsContactDataField(String ic, String details) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(ic,
            height: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 42.66
                : 18,
            width: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 42.66
                : 18),
        buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        Expanded(
          child: Text(
            details,
            style: GoogleFonts.hind(
              color: AppColors.text_color_black,
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 48
                  : 16,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Education"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        widget.customerEducationList!.isEmpty
            ? Column(
                children: List.generate(
                  2,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleSubText("June 2005 - May 2010"),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 38.4
                              : 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText("Los Angeles University"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0")
                              ],
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerEducationList!.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}"),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 38.4
                              : 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText(widget
                                    .customerEducationList![index].university),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    widget.customerEducationList![index].degree)
                              ],
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Widget _buildEmployment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Employment"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        widget.customerEmploymentList!.isEmpty
            ? Column(
                children: List.generate(
                  3,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleSubText("Sep 2012 - Dec 2015"),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 38.4
                              : 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText("UI Designer at Market Studios"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.")
                              ],
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerEmploymentList!.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 38.4
                              : 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText(
                                    "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(widget
                                    .customerEmploymentList![index].address)
                              ],
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Widget _buildSkils(int summaryCardCrossAxisCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Skills"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        widget.customerSkillList!.isEmpty
            ? SizedBox(
                width: double.infinity,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final summaryCardWidth = ((constraints.maxWidth -
                                (kDefaultPadding *
                                    (summaryCardCrossAxisCount - 1))) /
                            summaryCardCrossAxisCount -
                        kDefaultPadding);
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Figma",
                              style: GoogleFonts.hind(
                                  color: AppColors.text_color_black),
                            ),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 72
                                : kDefaultPadding / 1.5),
                            SizedBox(
                              height: 5,
                              width: summaryCardWidth,
                              child: LinearProgressIndicator(
                                value: 0.8,
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.3),
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 48
                                : kDefaultPadding),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final summaryCardWidth = ((constraints.maxWidth -
                                (kDefaultPadding *
                                    (summaryCardCrossAxisCount - 1))) /
                            summaryCardCrossAxisCount -
                        kDefaultPadding);
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        widget.customerSkillList!.length,
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.customerSkillList![index].skill,
                              style: GoogleFonts.hind(
                                  color: AppColors.text_color_black),
                            ),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 72
                                : kDefaultPadding / 1.5),
                            SizedBox(
                              height: 5,
                              width: summaryCardWidth,
                              child: LinearProgressIndicator(
                                value: widget.customerSkillList![index].level /
                                    100,
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.3),
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(2.5),
                              ),
                            ),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 48
                                : kDefaultPadding),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }
}
