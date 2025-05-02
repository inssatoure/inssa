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

class ResumeTemplatesList2 extends StatefulWidget {
  ResumeTemplatesList2({
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
  State<ResumeTemplatesList2> createState() => _ResumeTemplatesList2State();
}

class _ResumeTemplatesList2State extends State<ResumeTemplatesList2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 920 * 0.413,
      width: 709 * 0.440,
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * 0.413),
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
        fontSize: 18 * 0.413,
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

  Widget _buildProfileDetails() {
    return Container(
      width: 246 * 0.413,
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 27 * 0.413),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 96 * 0.413,
            width: 96 * 0.413,
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
          buildSizedBoxH(10 * 0.413),
          Text(
            "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
            style: GoogleFonts.sourceSerif4(
              fontSize: 28 * 0.413,
              color: AppColors.white_color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            widget.customerProfessiontext ?? "UI/UX Designer",
            style: GoogleFonts.hind(
              fontSize: 14 * 0.413,
              color: AppColors.white_color,
            ),
          ),
          buildSizedBoxH(24 * 0.413),
          _buildProfileDetailsContacts(),
          buildSizedBoxH(24 * 0.413),
          _buildProfileDetailsSkills(),
          buildSizedBoxH(24 * 0.413),
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
            fontSize: 16 * 0.413,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(5 * 0.413),
        widget.customerLocationtext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerLocationtext ?? "2207 Apple Avenue, Los Angeles",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: 14 * 0.413,
                ),
              ),
        widget.customerEmailIDtext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerEmailIDtext ?? "clifford@design.mail",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: 14 * 0.413,
                ),
              ),
        widget.customerWebsitetext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerWebsitetext ?? "www.clifford.design",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: 14 * 0.413,
                ),
              ),
        widget.customerPhoneNotext == ""
            ? const SizedBox.shrink()
            : Text(
                widget.customerPhoneNotext ?? "(914) 479-6342",
                style: GoogleFonts.hind(
                  color: AppColors.white_color.withOpacity(0.8),
                  fontSize: 14 * 0.413,
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
            fontSize: 16 * 0.413,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(10 * 0.413),
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
        titleSubText(skill, 14, AppColors.white_color),
        buildSizedBoxH(10 * 0.413),
        SizedBox(
          height: 5 * 0.413,
          child: LinearProgressIndicator(
            value: widget.customerSkillList!.isEmpty ? 0.8 : level / 100.0,
            backgroundColor: Colors.white.withOpacity(0.3),
            color: AppColors.white_color,
            borderRadius: BorderRadius.circular(2.5 * 0.413),
          ),
        ),
        buildSizedBoxH(16 * 0.413),
      ],
    );
  }

  Widget _buildOtherDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 27 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profile(),
          buildSizedBoxH(10 * 0.413),
          _buildEducation(),
          buildSizedBoxH(10 * 0.413),
          _buildEmployment(),
          buildSizedBoxH(10 * 0.413),
        ],
      ),
    );
  }

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Profile"),
        buildSizedBoxH(10 * 0.413),
        SizedBox(
          width: 380 * 0.413,
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
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText("Los Angeles University"),
                      buildSizedBoxH(5 * 0.413),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                          ),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText("2005 - 2010"),
                        ],
                      ),
                      buildSizedBoxH(10 * 0.413),
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
                      buildSizedBoxH(5 * 0.413),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                widget.customerEducationList![index].degree),
                          ),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText(
                              "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}"),
                        ],
                      ),
                      buildSizedBoxH(10 * 0.413),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headingText("UI Designer at Market Studios"),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText("2010 - 2012"),
                        ],
                      ),
                      buildSizedBoxH(5 * 0.413),
                      titleSubText(
                          "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
                      buildSizedBoxH(10 * 0.413),
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
                          buildSizedBoxW(16 * 0.413),
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                        ],
                      ),
                      buildSizedBoxH(5 * 0.413),
                      titleSubText(
                          widget.customerEmploymentList![index].address),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
