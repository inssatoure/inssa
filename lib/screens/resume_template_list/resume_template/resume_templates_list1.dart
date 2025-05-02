// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';
import 'package:quick_resume_creator/screens/create_resume/create_resume.dart';

class ResumeTemplatesList1 extends StatefulWidget {
  ResumeTemplatesList1({
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
    required this.customerProfessionalSkillList,
    required this.customerPersonalSkillList,
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
  List<ProfessionalSkill>? customerProfessionalSkillList;
  List<PersonalSkill>? customerPersonalSkillList;

  @override
  State<ResumeTemplatesList1> createState() => _ResumeTemplatesList1State();
}

class _ResumeTemplatesList1State extends State<ResumeTemplatesList1> {
  List skills = [
    "Figma",
    "Sketch App",
    "Adobe Photoshop",
    "Adobe Illustrator",
    "HTML/CSS",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 920 * 0.413,
      width: 709 * 0.417,
      child: Card(
        color: AppColors.white_color,
        elevation: 4 * 0.413,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * 0.413),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16 * 0.413,
            vertical: 16 * 0.413,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                                    networkImageURL:
                                        widget.customerProfileImageURL!)
                                : Image.asset(
                                    "assets/images/png/img_profile.png",
                                    fit: BoxFit.cover,
                                  ),
                      ),
                      buildSizedBoxW(20 * 0.413),
                      SizedBox(
                        width: 250 * 0.413,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.customerFirstNametext ?? "Jeremy"}\n${widget.customerLastNametext ?? "Clifford"}",
                              style: GoogleFonts.sourceSerif4(
                                fontSize: 28 * 0.413,
                                color: AppColors.text_color_black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.customerProfessiontext ?? "UI/UX Designer",
                              style: GoogleFonts.hind(
                                fontSize: 14 * 0.413,
                                color: AppColors.text_color_black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 230 * 0.413,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.customerLocationtext != ""
                            ? titleSubText(widget.customerLocationtext ??
                                "2207 Apple Avenue, Los Angeles")
                            : const SizedBox.shrink(),
                        widget.customerWebsitetext != ""
                            ? titleSubText(widget.customerWebsitetext ??
                                "Clifford@design.mail")
                            : const SizedBox.shrink(),
                        widget.customerEmailIDtext != ""
                            ? titleSubText(widget.customerEmailIDtext ??
                                "www.clifford.design")
                            : const SizedBox.shrink(),
                        widget.customerPhoneNotext != ""
                            ? titleSubText(
                                widget.customerPhoneNotext ?? "(914) 479-6342")
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
              buildSizedBoxH(10 * 0.413),
              const Divider(),
              buildSizedBoxH(10 * 0.413),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: profileColumn()),
                    const VerticalDivider(),
                    Expanded(child: employment()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profile(),
        buildSizedBoxH(10 * 0.413),
        education(),
        buildSizedBoxH(10 * 0.413),
        keySkills(),
        buildSizedBoxH(10 * 0.413),
      ],
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

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Profile"),
        buildSizedBoxH(8 * 0.413),
        titleSubText(widget.customerProfessionalSummarytext ??
            "Graphic designer with +8 years of experience..."),
      ],
    );
  }

  Widget education() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Education"),
        buildSizedBoxH(8 * 0.413),
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
                              children: [
                                headingText("Los Angeles University"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(
                                    "Bachelor of Fine Arts in Graphic Design"),
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
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              children: [
                                headingText(widget
                                    .customerEducationList![index].university),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(widget
                                    .customerEducationList![index].degree),
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

  Widget keySkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Key Skills"),
        buildSizedBoxH(8 * 0.413),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText("Professional"),
                  buildSizedBoxH(4 * 0.413),
                  widget.customerProfessionalSkillList!.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            skills.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6 * 0.413),
                              child: titleSubText(skills[index]),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.customerProfessionalSkillList!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6 * 0.413),
                              child: titleSubText(widget
                                  .customerProfessionalSkillList![index]
                                  .professionalSkill),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            buildSizedBoxW(10 * 0.413),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headingText("Personal"),
                  buildSizedBoxH(4 * 0.413),
                  widget.customerPersonalSkillList!.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            skills.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6 * 0.413),
                              child: titleSubText(skills[index]),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.customerPersonalSkillList!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6 * 0.413),
                              child: titleSubText(widget
                                  .customerPersonalSkillList![index]
                                  .personalSkill),
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget employment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Employment"),
        buildSizedBoxH(8 * 0.413),
        widget.customerEmploymentList!.isEmpty
            ? Column(
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("2012"),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("-"),
                              buildSizedBoxH(2 * 0.413),
                              titleSubText("2015"),
                            ],
                          ),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingText("UI Designer at Market Studios"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(
                                    "Successfully translated subject matter into design"),
                              ],
                            ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSizedBoxH(4 * 0.413),
                              titleSubText(widget
                                  .customerEmploymentList![index].startDate),
                              buildSizedBoxH(4 * 0.413),
                              titleSubText("-"),
                              buildSizedBoxH(2 * 0.413),
                              titleSubText(widget
                                  .customerEmploymentList![index].endDate),
                            ],
                          ),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingText(
                                    "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(widget
                                    .customerEmploymentList![index].address),
                              ],
                            ),
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
}
