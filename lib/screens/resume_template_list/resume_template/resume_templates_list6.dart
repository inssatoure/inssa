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

class ResumeTemplatesList6 extends StatefulWidget {
  ResumeTemplatesList6({
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
  State<ResumeTemplatesList6> createState() => _ResumeTemplatesList6State();
}

class _ResumeTemplatesList6State extends State<ResumeTemplatesList6> {
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
            borderRadius: BorderRadius.circular(10 * 0.413)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildOtherDetails(),
              ),
              _buildProfileDetails(),
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
          horizontal: 20 * 0.413, vertical: 20 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSizedBoxH(16 * 0.413),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "${AppImages.pngImage}img_bg_ring.png",
                    height: 148 * 0.413,
                    width: 148 * 0.413,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 7 * 0.413),
                    height: 96 * 0.413,
                    width: 96 * 0.413,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: widget.customerProfileImage != null
                        ? Image.memory(
                            widget.customerProfileImage!,
                            fit: BoxFit.cover,
                          )
                        : widget.customerProfileImageURL != null
                            ? CatchImageNetwork(
                                networkImageURL:
                                    widget.customerProfileImageURL!)
                            : Image.asset(
                                "assets/images/png/img_profile.png",
                                fit: BoxFit.cover,
                              ),
                  ),
                ],
              ),
            ],
          ),
          buildSizedBoxH(20 * 0.413),
          _buildContacts(),
          buildSizedBoxH(24 * 0.413),
          _buildSkills(),
        ],
      ),
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Contacts"),
        buildSizedBoxH(10 * 0.413),
        SizedBox(
          width: 260 * 0.413,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.customerPhoneNotext == ""
                  ? const SizedBox.shrink()
                  : Column(
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
        Image.asset(ic, height: 18 * 0.413, width: 18 * 0.413),
        buildSizedBoxW(10),
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

  Widget _buildSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Skills"),
        buildSizedBoxH(10 * 0.413),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  5,
                  (index) => _buildSkillProgressBar("Figma", 80 * 0.413),
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

  Widget _buildSkillProgressBar(String skills, double level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            buildSizedBoxW(10 * 0.413),
            Icon(Icons.circle,
                color: AppColors.text_darkgrey_color, size: 6 * 0.413),
            buildSizedBoxW(8 * 0.413),
            SizedBox(
              width: 180 * 0.413,
              child: Text(
                skills,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.hind(
                    fontSize: 14 * 0.413,
                    color: AppColors.text_color_black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        buildSizedBoxH(10 * 0.413),
        SizedBox(
          height: 5 * 0.413,
          child: LinearProgressIndicator(
            value: level / 100,
            backgroundColor: AppColors.primaryColor.withOpacity(0.3),
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(2.5 * 0.413),
          ),
        ),
        buildSizedBoxH(16 * 0.413),
      ],
    );
  }

  Widget _buildOtherDetails() {
    return Container(
      color: AppColors.lightgray_color,
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 20 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserName(),
          buildSizedBoxH(16 * 0.413),
          _buildProfile(),
          buildSizedBoxH(16 * 0.413),
          _buildEducation(),
          buildSizedBoxH(16 * 0.413),
          _buildEmployment(),
        ],
      ),
    );
  }

  Widget _buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
          style: GoogleFonts.sourceSerif4(
            fontSize: 28 * 0.413,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          widget.customerProfessiontext ?? "UI/UX Designer",
          style: GoogleFonts.hind(
            color: AppColors.text_color_black,
            fontSize: 18 * 0.413,
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
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
                children: List.generate(
                  3,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingText("UI Designer at Market Studios"),
                      buildSizedBoxH(5 * 0.413),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                "Successfully translated subject matter into  concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
                          ),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText("2012 - 2015"),
                        ],
                      ),
                      buildSizedBoxH(10 * 0.413),
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
                      headingText(
                          "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                      buildSizedBoxH(5 * 0.413),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: titleSubText(
                                widget.customerEmploymentList![index].address),
                          ),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
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
}
