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

class ResumeTemplatesList8 extends StatefulWidget {
  ResumeTemplatesList8({
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
  State<ResumeTemplatesList8> createState() => _ResumeTemplatesList8State();
}

class _ResumeTemplatesList8State extends State<ResumeTemplatesList8> {
  List skills = [
    "Figma",
    "Sketch App",
    "Adobe Photoshop",
    "Adobe Illustrator",
    "HTML/CSS",
    "Premiere Pro",
    "After Effects",
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 920 * 0.413,
      width: 709 * 0.413,
      child: Card(
        color: AppColors.white_color,
        elevation: 4,
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10 * 0.413),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20 * 0.413, vertical: 20 * 0.413),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildSizedBoxW(10 * 0.413),
                  Container(
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
                  buildSizedBoxW(20 * 0.413),
                  Column(
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
                  ),
                ],
              ),
              buildSizedBoxH(24 * 0.413),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileColumn(),
                  buildSizedBoxW(10 * 0.413),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profile(),
                      buildSizedBoxH(16 * 0.413),
                      employment(),
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileColumn() {
    return SizedBox(
      width: 246 * 0.413,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          education(),
          buildSizedBoxH(16 * 0.413),
          _buildContacts(),
          buildSizedBoxH(16 * 0.413),
          keySkills(),
        ],
      ),
    );
  }

  Widget titleText(String titleText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 18 * 0.413,
            color: AppColors.black_color,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(7 * 0.413),
        Container(
          height: 2 * 0.413,
          width: 30 * 0.413,
          color: AppColors.primaryColor,
        ),
      ],
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
                        _builsContactDataField("${AppImages.ic}ic_call.png",
                            widget.customerPhoneNotext ?? "(914) 479-6342"),
                        buildSizedBoxH(10 * 0.413),
                      ],
                    ),
              widget.customerLocationtext == ""
                  ? const SizedBox.shrink()
                  : Column(
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
                      children: [
                        _builsContactDataField(
                            "${AppImages.ic}ic_mail.png",
                            widget.customerEmailIDtext ??
                                "clifford@design.mail"),
                        buildSizedBoxH(10 * 0.413),
                      ],
                    ),
              widget.customerWebsitetext == ""
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _builsContactDataField(
                            "${AppImages.ic}ic_network.png",
                            widget.customerWebsitetext ??
                                "www.clifford.design"),
                        buildSizedBoxH(10 * 0.413),
                      ],
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
        buildSizedBoxH(10 * 0.413),
        titleSubText(widget.customerProfessionalSummarytext ??
            "Graphic designer with +8 years of experience in branding and print design. Skilled at Adobe Creative Suite (Photoshop, Illustrator) as well as sketching and hand drawing. Supervised 23 print design projects that resulted in an increase of 32% in savings."),
      ],
    );
  }

  Widget education() {
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                titleSubText("2005 - 2010"),
                                buildSizedBoxH(4 * 0.413),
                                headingText("Los Angeles University"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(
                                    "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0")
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                titleSubText(
                                    "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}"),
                                buildSizedBoxH(4 * 0.413),
                                headingText(widget
                                    .customerEducationList![index].university),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(
                                    widget.customerEducationList![index].degree)
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
        buildSizedBoxH(10 * 0.413),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  7,
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
                            "Adobe Photoshop",
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

  Widget employment() {
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
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText("2005 - 2010"),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText("UI Designer at Market Studios"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(
                                    "Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.")
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                          buildSizedBoxW(20 * 0.413),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText(
                                    "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                                buildSizedBoxH(4 * 0.413),
                                titleSubText(widget
                                    .customerEmploymentList![index].address)
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
