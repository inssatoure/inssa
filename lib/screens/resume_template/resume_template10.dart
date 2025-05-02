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

class ResumeTemplate10 extends StatefulWidget {
  ResumeTemplate10({
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
  State<ResumeTemplate10> createState() => _ResumeTemplate10State();
}

class _ResumeTemplate10State extends State<ResumeTemplate10> {
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
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 48
                  : kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileName(),
              buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 48
                  : kDefaultPadding),
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
            buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 256
                : 3),
            Image.asset(
              ic,
              height: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 38.4
                  : 20,
              width: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 38.4
                  : 20,
            ),
            buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 128
                : 6),
            Text(
              titleText,
              style: GoogleFonts.ibmPlexSans(
                fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                    ? MediaQuery.of(context).size.width / 42.66
                    : 18,
                color: AppColors.text_color_black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Divider(color: AppColors.dividercolor.withOpacity(0.5)),
      ],
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

  Widget _buildProfileName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (widget.customerFirstNametext ?? "Jeremy").toUpperCase(),
          style: GoogleFonts.sourceSerif4(
            letterSpacing: 10,
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 25.6
                : 30,
            color: AppColors.text_color_black,
          ),
        ),
        Text(
          (widget.customerLastNametext ?? "Clifford").toUpperCase(),
          style: GoogleFonts.sourceSerif4(
            letterSpacing: 10,
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 25.6
                : 30,
            color: AppColors.primaryColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 128
                : 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: AppColors.dividercolor.withOpacity(0.5)),
              Text(
                widget.customerProfessiontext ?? "UI/UX Designer",
                style: GoogleFonts.hind(
                  color: AppColors.text_color_black,
                  fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 42.66
                      : 18,
                ),
              ),
              Divider(color: AppColors.dividercolor.withOpacity(0.5)),
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
        buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 25.6
            : 30),
        Expanded(child: _buildUserQualifications()),
      ],
    );
  }

  Widget _buildProfileOtherDetails() {
    return SizedBox(
      width: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width / 3.2
          : 246,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfile(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildContacts(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
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
        titleText("${AppImages.ic}ic_contacts.png", "Contacts"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.customerPhoneNotext == ""
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      _buildContactsDetails("Phone No.",
                          widget.customerPhoneNotext ?? "(914) 479-6342"),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 109.71
                              : 7),
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
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 109.71
                              : 7),
                    ],
                  ),
            widget.customerEmailIDtext == ""
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      _buildContactsDetails("Email",
                          widget.customerEmailIDtext ?? "clifford@design.mail"),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 109.71
                              : 7),
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
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  5,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                          Icon(Icons.circle,
                              color: AppColors.text_darkgrey_color,
                              size: MediaQuery.of(context).size.width <=
                                      kScreenWidthMd
                                  ? MediaQuery.of(context).size.width / 128
                                  : 6),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 96
                              : 8),
                          Text(
                            "Skill ${index + 1}",
                            style: GoogleFonts.hind(
                              color: AppColors.text_darkgrey_color,
                              fontSize: MediaQuery.of(context).size.width <=
                                      kScreenWidthMd
                                  ? MediaQuery.of(context).size.width / 48
                                  : 16,
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
                  widget.customerSkillList!.length,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                          Icon(Icons.circle,
                              color: AppColors.text_darkgrey_color,
                              size: MediaQuery.of(context).size.width <=
                                      kScreenWidthMd
                                  ? MediaQuery.of(context).size.width / 128
                                  : 6),
                          buildSizedBoxW(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 96
                              : 8),
                          Expanded(
                            child: Text(
                              widget.customerSkillList![index].skill,
                              style: GoogleFonts.hind(
                                color: AppColors.text_darkgrey_color,
                                fontSize: MediaQuery.of(context).size.width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 48
                                    : 16,
                              ),
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

  Widget _buildUserQualifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEmployment(),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 48
            : kDefaultPadding),
        _buildEducation(),
      ],
    );
  }

  Widget _buildEmployment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("${AppImages.ic}ic_employment.png", "Employment"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
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
                          buildSizedBoxH(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 192
                              : kTextPadding),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingText("UI Designer at Market Studios"),
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText(
                                  "Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.")
                            ],
                          ),
                        ],
                      ),
                      buildSizedBoxH(14),
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
                          buildSizedBoxH(MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 192
                              : kTextPadding),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              headingText(
                                  "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText(
                                  widget.customerEmploymentList![index].address)
                            ],
                          ),
                        ],
                      ),
                      buildSizedBoxH(14),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText("2005"),
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText("-"),
                              buildSizedBoxH(2),
                              titleSubText("2010"),
                            ],
                          ),
                          buildSizedBoxW(20),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 3.07
                                      : 250,
                                  child: titleSubText(
                                      "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildSizedBoxH(10),
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
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText(widget
                                  .customerEducationList![index].startDate),
                              buildSizedBoxH(
                                  MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 192
                                      : kTextPadding),
                              titleSubText("-"),
                              buildSizedBoxH(2),
                              titleSubText(
                                  widget.customerEducationList![index].endDate),
                            ],
                          ),
                          buildSizedBoxW(20),
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width <=
                                          kScreenWidthMd
                                      ? MediaQuery.of(context).size.width / 3.07
                                      : 250,
                                  child: titleSubText(widget
                                      .customerEducationList![index].degree),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildSizedBoxH(10),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
