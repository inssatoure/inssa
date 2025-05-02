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

class ResumeTemplate8 extends StatefulWidget {
  ResumeTemplate8({
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
  State<ResumeTemplate8> createState() => _ResumeTemplate8State();
}

class _ResumeTemplate8State extends State<ResumeTemplate8> {
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
        shadowColor: AppColors.black_color.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
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
              Row(
                children: [
                  buildSizedBoxW(
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? MediaQuery.of(context).size.width / 76.8
                          : 10),
                  Container(
                    height: MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 8
                        : 96,
                    width: MediaQuery.of(context).size.width <= kScreenWidthMd
                        ? MediaQuery.of(context).size.width / 8
                        : 96,
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
                  buildSizedBoxW(
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? MediaQuery.of(context).size.width / 38.4
                          : 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.customerFirstNametext ?? "Jeremy"} ${widget.customerLastNametext ?? "Clifford"}",
                        style: GoogleFonts.sourceSerif4(
                          fontSize: MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 27.42
                              : 28,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        widget.customerProfessiontext ?? "UI/UX Designer",
                        style: GoogleFonts.hind(
                          color: AppColors.text_color_black,
                          fontSize: MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 42.66
                              : 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 32
                  : kDefaultPadding * 1.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileColumn(),
                  buildSizedBoxW(
                      MediaQuery.of(context).size.width <= kScreenWidthMd
                          ? MediaQuery.of(context).size.width / 24
                          : kDefaultPadding * 2),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profile(),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 48
                              : kDefaultPadding),
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
      width: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width / 3.2
          : 246,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          education(),
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

  Widget titleText(String titleText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: GoogleFonts.ibmPlexSans(
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 42.66
                : 18,
            color: AppColors.black_color,
            fontWeight: FontWeight.w700,
          ),
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 109.71
            : 7),
        Container(
          height: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 384
              : 2,
          width: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 25.6
              : 30,
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
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        SizedBox(
          width: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 2.95
              : 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.customerPhoneNotext == ""
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        _builsContactDataField("${AppImages.ic}ic_call.png",
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
                            "${AppImages.ic}ic_location.png",
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
                            "${AppImages.ic}ic_mail.png",
                            widget.customerEmailIDtext ??
                                "clifford@design.mail"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthMd
                                ? MediaQuery.of(context).size.width / 76.8
                                : 10),
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

  Widget profile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Profile"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                titleSubText("2005 - 2010"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                headingText("Los Angeles University"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    "Bachelor of Fine Arts in Graphic Design, GPA: 3.4/4.0")
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                titleSubText(
                                    "${widget.customerEducationList![index].startDate} - ${widget.customerEducationList![index].endDate}"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                headingText(widget
                                    .customerEducationList![index].university),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    widget.customerEducationList![index].degree)
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

  Widget keySkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Key Skills"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 76.8
            : 10),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  7,
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
                            "Adobe Photoshop",
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

  Widget employment() {
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
                  3,
                  (index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText("2005 - 2010"),
                          buildSizedBoxW(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText("UI Designer at Market Studios"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(
                                    "Successfully translated subject matter into concrete design for newsletters, promotional materials and sales collateral. Created design graphics for marketing and sales presentations, training videos and corporate websites.")
                              ],
                            ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${widget.customerEmploymentList![index].startDate} - ${widget.customerEmploymentList![index].endDate}"),
                          buildSizedBoxW(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                headingText(
                                    "${widget.customerEmploymentList![index].jobTitle} at ${widget.customerEmploymentList![index].companyName}"),
                                buildSizedBoxH(MediaQuery.of(context)
                                            .size
                                            .width <=
                                        kScreenWidthMd
                                    ? MediaQuery.of(context).size.width / 192
                                    : kTextPadding),
                                titleSubText(widget
                                    .customerEmploymentList![index].address)
                              ],
                            ),
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
}
