import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/pdf/pdf_colors/app_pdf_colors.dart';
import 'package:quick_resume_creator/core/pdf/pdf_fonts/app_pdf_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/skill.dart';

void pdfResumeTemplete10(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
  final ibmPlexSansw500 = await PDFFonts.ibmPlexSansSemiBold();
  final ibmPlexSansw700 = await PDFFonts.ibmPlexSansBold();
  final sourceSerif4 = await PDFFonts.sourceSerif4();

  List<Education> customerEducationList =
      (resumeData['customerEducationList'] as List)
          .map((e) => Education.fromJson(e))
          .toList();

  List<Employment> customerEmploymentList =
      (resumeData['customerEmploymentList'] as List)
          .map((e) => Employment.fromJson(e))
          .toList();

  List<Skill> customerSkillList = (resumeData['customerSkillList'] as List)
      .map((e) => Skill.fromJson(e))
      .toList();

  final profileImageData =
      await rootBundle.load("${AppImages.ic}ic_profile.png");
  final profileTitleImage =
      pw.MemoryImage(profileImageData.buffer.asUint8List());

  final contactsImageData =
      await rootBundle.load("${AppImages.ic}ic_contacts.png");
  final contactsTitleImage =
      pw.MemoryImage(contactsImageData.buffer.asUint8List());

  final skillsImageData = await rootBundle.load("${AppImages.ic}ic_skills.png");
  final skillsTitleImage = pw.MemoryImage(skillsImageData.buffer.asUint8List());

  final employmentImageData =
      await rootBundle.load("${AppImages.ic}ic_employment.png");
  final employmentImage =
      pw.MemoryImage(employmentImageData.buffer.asUint8List());

  final educationImageData =
      await rootBundle.load("${AppImages.ic}ic_education.png");
  final educationTitleImage =
      pw.MemoryImage(educationImageData.buffer.asUint8List());

  pw.Widget titleText(pw.ImageProvider ic, String titleText) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.SizedBox(width: 3),
            pw.Container(
                height: 18,
                width: 18,
                decoration: pw.BoxDecoration(
                  image: pw.DecorationImage(image: ic, fit: pw.BoxFit.contain),
                )),
            pw.SizedBox(width: 6),
            pw.Text(
              titleText,
              style: pw.TextStyle(
                font: ibmPlexSansw700,
                fontSize: 16,
                color: PDFColors.text_color_black,
              ),
            ),
          ],
        ),
        pw.Container(
          height: 1,
          color: PDFColors.dividercolor.shade(0.5),
          margin: const pw.EdgeInsets.only(top: 3.7),
        )
      ],
    );
  }

  pw.Widget headingText(String headingText,
      [double? fontSize, PdfColor? color]) {
    return pw.Text(
      headingText,
      style: pw.TextStyle(
        font: ibmPlexSansw500,
        fontSize: fontSize ?? 14,
        color: color ?? PDFColors.text_color_black,
      ),
    );
  }

  pw.Widget titleSubText(String titleSubText,
      [double? fontSize, PdfColor? color, pw.TextStyle? style]) {
    return pw.Text(
      titleSubText,
      style: style ??
          pw.TextStyle(
            font: hind,
            fontSize: fontSize ?? 13,
            color: color ?? PDFColors.text_darkgrey_color,
          ),
    );
  }

  pw.Widget buildProfileName() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          resumeData['customerFirstNametext'].toUpperCase(),
          style: pw.TextStyle(
            font: sourceSerif4,
            letterSpacing: 10,
            fontSize: 30,
            color: PDFColors.text_color_black,
          ),
        ),
        pw.Text(
          resumeData['customerLastNametext'].toUpperCase(),
          style: pw.TextStyle(
            font: sourceSerif4,
            letterSpacing: 10,
            fontSize: 30,
            color: PDFColors.primaryColor,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 6),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Divider(color: PDFColors.dividercolor.shade(0.5)),
              pw.Text(
                resumeData['customerProfessiontext'],
                style: pw.TextStyle(
                  color: PDFColors.text_color_black,
                  fontSize: 18,
                ),
              ),
              pw.Divider(color: PDFColors.dividercolor.shade(0.5)),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildProfile() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(profileTitleImage, "Profile"),
        pw.SizedBox(height: 10),
        titleSubText(resumeData['customerProfessionalSummarytext']),
      ],
    );
  }

  pw.Widget buildContactsDetails(String titleText, String subText) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        headingText(titleText),
        titleSubText(subText),
      ],
    );
  }

  pw.Widget buildContacts() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(contactsTitleImage, "Contacts"),
        pw.SizedBox(height: 10),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            resumeData['customerPhoneNotext'] == ""
                ? pw.SizedBox.shrink()
                : pw.Column(
                    children: [
                      buildContactsDetails(
                          "Phone No.", resumeData['customerPhoneNotext']),
                      pw.SizedBox(height: 7),
                    ],
                  ),
            resumeData['customerLocationtext'] == ""
                ? pw.SizedBox.shrink()
                : pw.Column(
                    children: [
                      buildContactsDetails(
                          "Address", resumeData['customerLocationtext']),
                      pw.SizedBox(height: 7),
                    ],
                  ),
            resumeData['customerEmailIDtext'] == ""
                ? pw.SizedBox.shrink()
                : pw.Column(
                    children: [
                      buildContactsDetails(
                          "Email", resumeData['customerEmailIDtext']),
                      pw.SizedBox(height: 7),
                    ],
                  ),
            resumeData['customerWebsitetext'] == ""
                ? pw.SizedBox.shrink()
                : buildContactsDetails(
                    "Website", resumeData['customerWebsitetext']),
          ],
        )
      ],
    );
  }

  pw.Widget keySkills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(skillsTitleImage, "Skills"),
        pw.SizedBox(height: 10),
        customerSkillList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerSkillList.length,
                  (index) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.SizedBox(width: 10),
                          pw.Container(
                              height: 6,
                              width: 6,
                              decoration: pw.BoxDecoration(
                                color: PDFColors.text_darkgrey_color,
                                shape: pw.BoxShape.circle,
                              )),
                          pw.SizedBox(width: 8),
                          pw.Expanded(
                            child: titleSubText(customerSkillList[index].skill),
                          )
                        ],
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ),
              )
      ],
    );
  }

  pw.Widget buildProfileOtherDetails() {
    return pw.SizedBox(
      width: 218,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildProfile(),
          pw.SizedBox(height: kDefaultPadding),
          buildContacts(),
          pw.SizedBox(height: kDefaultPadding),
          keySkills(),
        ],
      ),
    );
  }

  pw.Widget buildEmployment() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(employmentImage, "Employment"),
        pw.SizedBox(height: 10),
        customerEmploymentList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerEmploymentList.length,
                  (index) => pw.Column(
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          titleSubText(
                              "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
                          pw.SizedBox(height: kTextPadding),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              headingText(
                                  "${customerEmploymentList[index].jobTitle} at ${customerEmploymentList[index].companyName}"),
                              pw.SizedBox(height: kTextPadding),
                              titleSubText(
                                  customerEmploymentList[index].address)
                            ],
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  pw.Widget buildEducation() {
    return pw.Column(
      children: [
        titleText(educationTitleImage, "Education"),
        pw.SizedBox(height: 10),
        customerEducationList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerEducationList.length,
                  (index) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: kTextPadding),
                              titleSubText(
                                  customerEducationList[index].startDate),
                              pw.SizedBox(height: kTextPadding),
                              titleSubText("-"),
                              pw.SizedBox(height: 2),
                              titleSubText(
                                  customerEducationList[index].endDate),
                            ],
                          ),
                          pw.SizedBox(width: 20),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                headingText(
                                    customerEducationList[index].university),
                                pw.SizedBox(height: kTextPadding),
                                pw.SizedBox(
                                  width: 226,
                                  child: titleSubText(
                                      customerEducationList[index].degree),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  pw.Widget buildUserQualifications() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        buildEmployment(),
        pw.SizedBox(height: kDefaultPadding),
        buildEducation(),
      ],
    );
  }

  pw.Widget buildProfileDetails() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        buildProfileOtherDetails(),
        pw.SizedBox(width: kDefaultPadding),
        pw.Expanded(child: buildUserQualifications()),
      ],
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(kDefaultPadding),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildProfileName(),
            pw.SizedBox(height: kDefaultPadding),
            buildProfileDetails(),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
