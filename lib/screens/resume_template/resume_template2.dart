// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/skill.dart';
import 'package:quick_resume_creator/screens/create_resume/create_resume.dart';

class ResumeTemplate2 extends StatefulWidget {
  ResumeTemplate2({
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
  State<ResumeTemplate2> createState() => _ResumeTemplate2State();
}

class _ResumeTemplate2State extends State<ResumeTemplate2> {
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileDetails(),
              Expanded(
                child: _buildOtherDetails(),
              ),
            ],
          ),
        ),
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

  Widget _buildProfileDetails() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                  ? MediaQuery.of(context).size.width / 27.42
                  : 28,
              color: AppColors.white_color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.customerProfessiontext ?? "UI/UX Designer",
            style: GoogleFonts.hind(
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 54.85
                  : 14,
              color: AppColors.white_color,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 32
              : kDefaultPadding * 1.5),
          _buildProfileDetailsContacts(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 32
              : kDefaultPadding * 1.5),
          _buildProfileDetailsSkills(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 32
              : kDefaultPadding * 1.5),
        ],
      ),
    );
  }

  Widget _buildProfileDetailsContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contacts",
          style: GoogleFonts.ibmPlexSans(
            color: AppColors.white_color,
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 48
                : 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 153
            : kTextPadding + 1),
        widget.customerLocationtext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerLocationtext ?? "2207 Apple Avenue, Los Angeles",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 54.85
                      : 14,
                ),
              ),
        widget.customerEmailIDtext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerEmailIDtext ?? "clifford@design.mail",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 54.85
                      : 14,
                ),
              ),
        widget.customerWebsitetext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerWebsitetext ?? "www.clifford.design",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 54.85
                      : 14,
                ),
              ),
        widget.customerPhoneNotext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerPhoneNotext ?? "(914) 479-6342",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 54.85
                      : 14,
                ),
              ),
      ],
    );
  }

  Widget _buildProfileDetailsSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Skills",
          style: GoogleFonts.ibmPlexSans(
            color: AppColors.white_color,
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 48
                : 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 72
            : kDefaultPadding / 1.5),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  5,
                  (index) => _buildSkillProgressBar("Figma", 0.8),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerSkillList!.length,
                  (index) => _buildSkillProgressBar(
                      widget.customerSkillList![index].skill,
                      widget.customerSkillList![index].level),
                ),
              ),
      ],
    );
  }

  Widget _buildSkillProgressBar(String skill, double level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skill,
          style: GoogleFonts.hind(color: AppColors.white_color),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 72
            : kDefaultPadding / 1.5),
        SizedBox(
          height: 5,
          child: LinearProgressIndicator(
            value: widget.customerSkillList!.isEmpty ? 0.8 : level / 100.0,
            backgroundColor: Colors.white.withOpacity(0.3),
            color: AppColors.white_color,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 48
            : kDefaultPadding),
      ],
    );
  }

  Widget _buildOtherDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 38.4
              : 20,
          vertical: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 28.4
              : 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profile(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
          _buildEducation(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
          _buildEmployment(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
        ],
      ),
    );
  }

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Profile"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        SizedBox(
          width: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 2.02
              : 380,
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
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText("Los Angeles University"),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 153
                              : kTextPadding + 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                          ),
                          buildSizedBoxW(kDefaultPadding),
                          titleSubText("2005 - 2010"),
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
                      headingText(
                          widget.customerEducationList![index].university),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 153
                              : kTextPadding + 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                widget.customerEducationList![index].degree),
                          ),
                          buildSizedBoxW(kDefaultPadding),
                          titleSubText(
                              "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}"),
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingText("UI Designer at Market Studios"),
                          buildSizedBoxW(kDefaultPadding),
                          titleSubText("2010 - 2012"),
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 153
                              : kTextPadding + 1),
                      titleSubText(
                          "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.customerEmploymentList!.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: headingText(
                                "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                          ),
                          buildSizedBoxW(kDefaultPadding),
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                        ],
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 153
                              : kTextPadding + 1),
                      titleSubText(
                          widget.customerEmploymentList![index].address),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
