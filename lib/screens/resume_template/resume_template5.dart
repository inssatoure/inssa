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

class ResumeTemplate5 extends StatefulWidget {
  ResumeTemplate5({
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
  State<ResumeTemplate5> createState() => _ResumeTemplate5State();
}

class _ResumeTemplate5State extends State<ResumeTemplate5> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width <= kScreenWidthSm
          ? MediaQuery.of(context).size.height * 0.73
          : MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width * 1.27
              : 920,
      width: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width
          : 709,
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildbg(),
                ],
              ),
              _buildDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildbg() {
    return Container(
      width: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width / 3.2
          : 246,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 38.4
              : 20,
          vertical: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 28.4
              : 27),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 38.9
              : 22,
          vertical: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 28.4
              : 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileDetails(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildContacts(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildProfile(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildEducation(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildEmployment(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildSkills(),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 3.01
              : 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.customerProfessiontext ?? "UI/UX Designer",
            style: GoogleFonts.hind(
              color: AppColors.text_darkgrey_color,
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 48
                  : 16,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 192
              : kTextPadding),
          Text(
            "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
            style: GoogleFonts.sourceSerif4(
                fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                    ? MediaQuery.of(context).size.width / 30.72
                    : 25,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget titleText(String titleText) {
    return Text(
      titleText,
      style: GoogleFonts.ibmPlexSans(
        fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 42.66
            : 18,
        color: AppColors.white_color,
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

  Widget _buildContacts() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        titleText("Contacts"),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 3.01
                  : 255),
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        titleText("Profile"),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 3.01
                  : 255),
          child: titleSubText(widget.customerProfessionalSummarytext ??
              "Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings."),
        ),
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
                  (index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      titleSubText(
                          "June 2005 - May 2010", null, AppColors.white_color),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 3.01
                                : 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText("Los Angeles University"),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 192
                                : kTextPadding),
                            titleSubText(
                                "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerEducationList!.length,
                  (index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      titleSubText(
                          "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}",
                          null,
                          AppColors.white_color),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 3.01
                                : 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText(widget
                                .customerEducationList![index].university),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 192
                                : kTextPadding),
                            titleSubText(
                                widget.customerEducationList![index].degree),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                  2,
                  (index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      titleSubText(
                          "Sep 2012 - Dec 2015", null, AppColors.white_color),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 3.01
                                : 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText("UI Designer at Market Studios"),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 192
                                : kTextPadding),
                            titleSubText(
                                "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerEmploymentList!.length,
                  (index) => Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      titleSubText(
                          "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}",
                          null,
                          AppColors.white_color),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 3.01
                                : 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText(
                                "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 192
                                : kTextPadding),
                            titleSubText(
                                widget.customerEmploymentList![index].address),
                            buildSizedBoxH(MediaQuery.of(context).size.width <=
                                    kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildSkills() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        titleText("Skills"),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 3.01
                  : 255),
          child: Row(
            children: [
              widget.customerSkillList!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        6,
                        (index) => Row(
                          children: [
                            titleSubText(
                              "Figma",
                              null,
                              null,
                              GoogleFonts.hind(
                                  color: AppColors.black_color,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        widget.customerSkillList!.length,
                        (index) => SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 3.2
                              : 206,
                          child: titleSubText(
                            widget.customerSkillList![index].skill,
                            null,
                            null,
                            GoogleFonts.hind(
                                color: AppColors.black_color,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
              buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 9.6
                  : kDefaultPadding * 5),
              widget.customerSkillList!.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        6,
                        (index) => titleSubText("Expert"),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        widget.customerSkillList!.length,
                        (index) => titleSubText(widget
                                    .customerSkillList![index].level ==
                                20
                            ? "Beginner"
                            : widget.customerSkillList![index].level == 40
                                ? "Moderate"
                                : widget.customerSkillList![index].level == 60
                                    ? "Good"
                                    : widget.customerSkillList![index].level ==
                                            80
                                        ? "Very good"
                                        : widget.customerSkillList![index]
                                                    .level ==
                                                100
                                            ? "Expert"
                                            : "Make a choice"),
                      ),
                    ),
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
}
