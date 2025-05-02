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

class ResumeTemplatesList3 extends StatefulWidget {
  ResumeTemplatesList3({
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
  State<ResumeTemplatesList3> createState() => _ResumeTemplatesList3State();
}

class _ResumeTemplatesList3State extends State<ResumeTemplatesList3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 920 * 0.413,
      width: 709 * 0.413,
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppColors.black_color.withOpacity(0.413),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * 0.413),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileDetails(),
                Expanded(
                  child: _buildOtherDetails(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      width: 246 * 0.413,
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 27 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileAndUsername(),
          buildSizedBoxH(16 * 0.413),
          _buildPosition(),
          buildSizedBoxH(19 * 0.413),
          _buildContacts(),
          buildSizedBoxH(19 * 0.413),
          _buildKeySkills(),
        ],
      ),
    );
  }

  Widget _buildOtherDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 20 * 0.413, vertical: 27 * 0.413),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildprofile(),
          buildSizedBoxH(10 * 0.413),
          _buildEducation(),
          buildSizedBoxH(10 * 0.413),
          _buildEmployment(),
        ],
      ),
    );
  }

  Widget _buildProfileAndUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 96 * 0.413,
          width: 96 * 0.413,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.gray_color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
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
            color: AppColors.text_color_black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPosition() {
    return Column(
      children: [
        _buildTitleText("Position"),
        buildSizedBoxH(16 * 0.413),
        Text(
          widget.customerProfessiontext ?? "UI/UX Designer",
          textAlign: TextAlign.center,
          style: GoogleFonts.hind(fontSize: 18 * 0.413),
        ),
      ],
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Contacts"),
        buildSizedBoxH(16 * 0.413),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.customerPhoneNotext == ""
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _builsContactDataField("${AppImages.ic}ic_call.png",
                          widget.customerPhoneNotext ?? "(914) 479-6342"),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
            widget.customerLocationtext == ""
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _builsContactDataField(
                          "${AppImages.ic}ic_location.png",
                          widget.customerLocationtext ??
                              "2207 Apple Avenue, Los Angeles"),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
            widget.customerEmailIDtext == ""
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _builsContactDataField("${AppImages.ic}ic_mail.png",
                          widget.customerEmailIDtext ?? "clifford@design.mail"),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
            widget.customerWebsitetext == ""
                ? const SizedBox.shrink()
                : _builsContactDataField("${AppImages.ic}ic_network.png",
                    widget.customerWebsitetext ?? "www.clifford.design"),
          ],
        ),
      ],
    );
  }

  Widget _buildTitleText(String titleText) {
    return Container(
      height: 45 * 0.413,
      width: 170 * 0.413,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.text_color_black, width: 0.8)),
      child: Center(
        child: Text(
          titleText,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 18 * 0.413,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _builsContactDataField(String ic, String details) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildSizedBoxW(12 * 0.413),
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

  Widget _buildKeySkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Key Skills"),
        buildSizedBoxH(16 * 0.413),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  6,
                  (index) => Row(
                    children: [
                      buildSizedBoxW(10 * 0.413),
                      Icon(Icons.circle,
                          color: AppColors.text_darkgrey_color,
                          size: 6 * 0.413),
                      buildSizedBoxW(8 * 0.413),
                      Text(
                        "Adobe Photoshop",
                        style: GoogleFonts.hind(
                          color: AppColors.text_darkgrey_color,
                          fontSize: 16 * 0.413,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerSkillList!.length,
                  (index) => Row(
                    children: [
                      buildSizedBoxW(10 * 0.413),
                      Icon(Icons.circle,
                          color: AppColors.text_darkgrey_color,
                          size: 6 * 0.413),
                      buildSizedBoxW(8 * 0.413),
                      Expanded(
                        child: Text(
                          widget.customerSkillList![index].skill,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.hind(
                            color: AppColors.text_darkgrey_color,
                            fontSize: 16 * 0.413,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
      ],
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

  Widget _buildprofile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Profile"),
        buildSizedBoxH(8 * 0.413),
        titleSubText(widget.customerProfessionalSummarytext ??
            "Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings."),
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Education"),
        buildSizedBoxH(8 * 0.413),
        widget.customerEducationList!.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
        _buildTitleText("Employment"),
        buildSizedBoxH(8 * 0.413),
        widget.customerEmploymentList!.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  3,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child:
                                  headingText("UI Designer at Market Studios")),
                          buildSizedBoxW(16 * 0.413),
                          titleSubText("2010 - 2012"),
                        ],
                      ),
                      buildSizedBoxH(5 * 0.413),
                      titleSubText(
                          "Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites."),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
