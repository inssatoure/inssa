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

class ResumeTemplatesList10 extends StatefulWidget {
  ResumeTemplatesList10({
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
  State<ResumeTemplatesList10> createState() => _ResumeTemplatesList10State();
}

class _ResumeTemplatesList10State extends State<ResumeTemplatesList10> {
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
        child: Padding(
          padding: const EdgeInsets.all(10 * 0.413),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileName(),
              buildSizedBoxH(15 * 0.413),
              _buildProfileDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleText(String ic, String titleText) {
    return Column(
      children: [
        Row(
          children: [
            buildSizedBoxW(3 * 0.413),
            Image.asset(ic, height: 20 * 0.413, width: 20 * 0.413),
            buildSizedBoxW(6 * 0.413),
            Text(
              titleText,
              style: GoogleFonts.ibmPlexSans(
                fontSize: 18 * 0.413,
                color: AppColors.text_color_black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        buildSizedBoxH(10 * 0.413),
        Divider(color: AppColors.dividercolor.withOpacity(0.5), height: 1),
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

  Widget _buildProfileName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (widget.customerFirstNametext ?? "Jeremy").toUpperCase(),
          style: GoogleFonts.sourceSerif4(
            letterSpacing: 10 * 0.413,
            fontSize: 30 * 0.413,
            color: AppColors.text_color_black,
          ),
        ),
        Text(
          (widget.customerLastNametext ?? "Clifford").toUpperCase(),
          style: GoogleFonts.sourceSerif4(
            letterSpacing: 10 * 0.413,
            fontSize: 30 * 0.413,
            color: AppColors.primaryColor,
          ),
        ),
        buildSizedBoxH(8 * 0.413),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6 * 0.413),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                  color: AppColors.dividercolor.withOpacity(0.5), height: 1),
              buildSizedBoxH(5 * 0.413),
              Text(
                widget.customerProfessiontext ?? "UI/UX Designer",
                style: GoogleFonts.hind(
                  color: AppColors.text_color_black,
                  fontSize: 18 * 0.413,
                ),
              ),
              buildSizedBoxH(5 * 0.413),
              Divider(
                  color: AppColors.dividercolor.withOpacity(0.5), height: 1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileOtherDetails(),
        buildSizedBoxW(30 * 0.413),
        Expanded(child: _buildUserQualifications()),
      ],
    );
  }

  Widget _buildProfileOtherDetails() {
    return SizedBox(
      width: 246 * 0.413,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfile(),
          buildSizedBoxH(10 * 0.413),
          _buildContacts(),
          buildSizedBoxH(10 * 0.413),
          keySkills(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("${AppImages.ic}ic_profile.png", "Profile"),
        buildSizedBoxH(10 * 0.413),
        titleSubText(widget.customerProfessionalSummarytext ??
            "Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings."),
      ],
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("${AppImages.ic}ic_contacts.png", "Contacts"),
        buildSizedBoxH(10 * 0.413),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.customerPhoneNotext == ""
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      _buildContactsDetails("Phone No.",
                          widget.customerPhoneNotext ?? "(914) 479-6342"),
                      buildSizedBoxH(7 * 0.413),
                    ],
                  ),
            widget.customerLocationtext == ""
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      _buildContactsDetails(
                          "Address",
                          widget.customerLocationtext ??
                              "2207 Apple Avenue, Los Angeles"),
                      buildSizedBoxH(7 * 0.413),
                    ],
                  ),
            widget.customerEmailIDtext == ""
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      _buildContactsDetails("Email",
                          widget.customerEmailIDtext ?? "clifford@design.mail"),
                      buildSizedBoxH(7 * 0.413),
                    ],
                  ),
          ],
        )
      ],
    );
  }

  Widget _buildContactsDetails(String titleText, String subText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingText(titleText),
        titleSubText(subText),
      ],
    );
  }

  Widget keySkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("${AppImages.ic}ic_skills.png", "Skills"),
        buildSizedBoxH(10 * 0.413),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildSizedBoxW(10 * 0.413),
                          Icon(Icons.circle,
                              color: AppColors.text_darkgrey_color,
                              size: 6 * 0.413),
                          buildSizedBoxW(8 * 0.413),
                          Text(
                            "Skill ${index + 1}",
                            style: GoogleFonts.hind(
                              color: AppColors.text_darkgrey_color,
                              fontSize: 16 * 0.413,
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerSkillList!.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildSizedBoxW(10 * 0.413),
                          Icon(Icons.circle,
                              color: AppColors.text_darkgrey_color,
                              size: 6 * 0.413),
                          buildSizedBoxW(8 * 0.413),
                          Expanded(
                            child: Text(
                              widget.customerSkillList![index].skill,
                              style: GoogleFonts.hind(
                                color: AppColors.text_darkgrey_color,
                                fontSize: 16 * 0.413,
                              ),
                            ),
                          )
                        ],
                      ),
                      buildSizedBoxH(10 * 0.413),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  Widget _buildUserQualifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEmployment(),
        buildSizedBoxH(10 * 0.413),
        _buildEducation(),
      ],
    );
  }

  Widget _buildEmployment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("${AppImages.ic}ic_employment.png", "Employment"),
        buildSizedBoxH(10 * 0.413),
        widget.customerEmploymentList!.isEmpty
            ? Column(
                children: List.generate(
                  2,
                  (index) => Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText("2005 - 2010"),
                          buildSizedBoxH(4 * 0.413),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingText("UI Designer at Market Studios"),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText(
                                  "Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.")
                            ],
                          ),
                        ],
                      ),
                      buildSizedBoxH(14 * 0.413),
                    ],
                  ),
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerEmploymentList!.length,
                  (index) => Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                          buildSizedBoxH(4 * 0.413),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingText(
                                  "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText(
                                  widget.customerEmploymentList![index].address)
                            ],
                          ),
                        ],
                      ),
                      buildSizedBoxH(14 * 0.413),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildEducation() {
    return Column(
      children: [
        titleText("${AppImages.ic}ic_education.png", "Education"),
        buildSizedBoxH(10 * 0.413),
        widget.customerEducationList!.isEmpty
            ? Column(
                children: List.generate(
                  2,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("2005"),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("-"),
                              buildSizedBoxH(2 * 0.413),
                              titleSubText("2010"),
                            ],
                          ),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText("Los Angeles University"),
                                buildSizedBoxH(4 * 0.413),
                                SizedBox(
                                  width: 250 * 0.413,
                                  child: titleSubText(
                                      "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                                )
                              ],
                            ),
                          ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildSizedBoxH(4 * 0.413),
                              titleSubText(widget
                                  .customerEducationList![index].startDate),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("-"),
                              buildSizedBoxH(2 * 0.413),
                              titleSubText(
                                  widget.customerEducationList![index].endDate),
                            ],
                          ),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText(widget
                                    .customerEducationList![index].university),
                                buildSizedBoxH(4 * 0.413),
                                SizedBox(
                                  width: 250 * 0.413,
                                  child: titleSubText(widget
                                      .customerEducationList![index].degree),
                                )
                              ],
                            ),
                          ),
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
