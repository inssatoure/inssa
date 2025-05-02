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

class ResumeTemplatesList5 extends StatefulWidget {
  ResumeTemplatesList5({
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
  State<ResumeTemplatesList5> createState() => _ResumeTemplatesList5State();
}

class _ResumeTemplatesList5State extends State<ResumeTemplatesList5> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 920 * 0.413,
      width: 709 * 0.413,
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * 0.413),
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
      width: 246 * 0.413,
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 20 * 0.413),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 22 * 0.413, vertical: 20 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileDetails(),
          buildSizedBoxH(16 * 0.413),
          _buildContacts(),
          buildSizedBoxH(16 * 0.413),
          _buildProfile(),
          buildSizedBoxH(16 * 0.413),
          _buildEducation(),
          buildSizedBoxH(16 * 0.413),
          _buildEmployment(),
          buildSizedBoxH(16 * 0.413),
          _buildSkills(),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 255 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.customerProfessiontext ?? "UI/UX Designer",
            style: GoogleFonts.hind(
              color: AppColors.text_darkgrey_color,
              fontSize: 16 * 0.413,
            ),
          ),
          buildSizedBoxH(4 * 0.413),
          Text(
            "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
            style: GoogleFonts.sourceSerif4(
                fontSize: 25 * 0.413, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget titleText(String titleText) {
    return Text(
      titleText,
      style: GoogleFonts.ibmPlexSans(
        fontSize: 18 * 0.413,
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
        fontSize: fontSize != null ? fontSize * 0.413 : 16 * 0.413,
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
            fontSize: fontSize != null ? fontSize * 0.413 : 14 * 0.413,
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
          padding: const EdgeInsets.only(left: 255 * 0.413),
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
                        buildSizedBoxH(10 * 0.413),
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
                        buildSizedBoxH(10 * 0.413),
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
                        buildSizedBoxH(10 * 0.413),
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
          padding: const EdgeInsets.only(left: 255 * 0.413),
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
        buildSizedBoxH(10 * 0.413),
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
                        padding: const EdgeInsets.only(left: 255 * 0.413),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText("Los Angeles University"),
                            buildSizedBoxH(4 * 0.413),
                            titleSubText(
                                "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                            buildSizedBoxH(10 * 0.413),
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
                        padding: const EdgeInsets.only(left: 255 * 0.413),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText(widget
                                .customerEducationList![index].university),
                            buildSizedBoxH(4 * 0.413),
                            titleSubText(
                                widget.customerEducationList![index].degree),
                            buildSizedBoxH(10 * 0.413),
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
        buildSizedBoxH(10 * 0.413),
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
                        padding: const EdgeInsets.only(left: 255 * 0.413),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText("UI Designer at Market Studios"),
                            buildSizedBoxH(4 * 0.413),
                            titleSubText(
                                "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
                            buildSizedBoxH(10 * 0.413),
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
                        padding: const EdgeInsets.only(left: 255 * 0.413),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headingText(
                                "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                            buildSizedBoxH(4 * 0.413),
                            titleSubText(
                                widget.customerEmploymentList![index].address),
                            buildSizedBoxH(10 * 0.413),
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
          padding: const EdgeInsets.only(left: 255 * 0.413),
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
                                  fontSize: 14 * 0.413,
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
                          width: 206 * 0.413,
                          child: titleSubText(
                            widget.customerSkillList![index].skill,
                            null,
                            null,
                            GoogleFonts.hind(
                                fontSize: 14 * 0.413,
                                color: AppColors.black_color,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
              buildSizedBoxW(80 * 0.413),
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
        Image.asset(ic, height: 18 * 0.413, width: 18 * 0.413),
        buildSizedBoxW(10 * 0.413),
        Expanded(
          child: Text(
            details,
            style: GoogleFonts.hind(
              color: AppColors.text_color_black,
              fontSize: 16 * 0.413,
            ),
          ),
        )
      ],
    );
  }
}
