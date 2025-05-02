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

class ResumeTemplate3 extends StatefulWidget {
  ResumeTemplate3({
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
  State<ResumeTemplate3> createState() => _ResumeTemplate3State();
}

class _ResumeTemplate3State extends State<ResumeTemplate3> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileAndUsername(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 48
              : kDefaultPadding),
          _buildPosition(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 42.66
              : kDefaultPadding + 3),
          _buildContacts(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 42.66
              : kDefaultPadding + 3),
          _buildKeySkills(),
        ],
      ),
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
          _buildprofile(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
          _buildEducation(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 72
              : kDefaultPadding / 1.5),
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
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 48
            : kDefaultPadding),
        Text(
          widget.customerProfessiontext ?? "UI/UX Designer",
          textAlign: TextAlign.center,
          style: GoogleFonts.hind(
              fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 42.66
                  : 18),
        ),
      ],
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Contacts"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 48
            : kDefaultPadding),
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
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
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
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                    ],
                  ),
            widget.customerEmailIDtext == ""
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _builsContactDataField("${AppImages.ic}ic_mail.png",
                          widget.customerEmailIDtext ?? "clifford@design.mail"),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
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
      height: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width / 17.06
          : 45,
      width: MediaQuery.of(context).size.width <= kScreenWidthMd
          ? MediaQuery.of(context).size.width / 4.51
          : 170,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.text_color_black, width: 0.8)),
      child: Center(
        child: Text(
          titleText,
          style: GoogleFonts.ibmPlexSans(
            fontSize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 42.66
                : 18,
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
        buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 64
            : 12),
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

  Widget _buildKeySkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Key Skills"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 48
            : kDefaultPadding),
        widget.customerSkillList!.isEmpty
            ? Column(
                children: List.generate(
                  6,
                  (index) => Row(
                    children: [
                      buildSizedBoxW(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                      Icon(Icons.circle,
                          color: AppColors.text_darkgrey_color,
                          size: MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 128
                              : 6),
                      buildSizedBoxW(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
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
                ),
              )
            : Column(
                children: List.generate(
                  widget.customerSkillList!.length,
                  (index) => Row(
                    children: [
                      buildSizedBoxW(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 76.8
                              : 10),
                      Icon(Icons.circle,
                          color: AppColors.text_darkgrey_color,
                          size: MediaQuery.of(context).size.width <=
                                  kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 128
                              : 6),
                      buildSizedBoxW(
                          MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 96
                              : 8),
                      Expanded(
                        child: Text(
                          widget.customerSkillList![index].skill,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

  Widget _buildprofile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("Profile"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 86
            : kDefaultPadding / 1.8),
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
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 86
            : kDefaultPadding / 1.8),
        widget.customerEducationList!.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
        _buildTitleText("Employment"),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthMd
            ? MediaQuery.of(context).size.width / 86
            : kDefaultPadding / 1.8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
