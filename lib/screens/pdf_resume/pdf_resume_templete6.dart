// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/pdf/pdf_colors/app_pdf_colors.dart';
import 'package:quick_resume_creator/core/pdf/pdf_fonts/app_pdf_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/skill.dart';

void pdfResumeTemplete6(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
  final hindw500 = await PDFFonts.hindMedium();
  final ibmPlexSansw500 = await PDFFonts.ibmPlexSansSemiBold();
  final ibmPlexSansw700 = await PDFFonts.ibmPlexSansBold();
  final sourceSerif4w600 = await PDFFonts.sourceSerif4SemiBold();

  final response =
      await http.get(Uri.parse(resumeData['customerProfileImage'] ?? ""));

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

  final Uint8List networkImage = response.bodyBytes;
  final image = pw.MemoryImage(networkImage);

  final profileRingImageData =
      await rootBundle.load("${AppImages.pngImage}img_bg_ring.png");
  final profileRingImage =
      pw.MemoryImage(profileRingImageData.buffer.asUint8List());

  final locationImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_location.png");
  final customerLocationImage =
      pw.MemoryImage(locationImageData.buffer.asUint8List());

  final emailIDImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_mail.png");
  final customerEmailIDImage =
      pw.MemoryImage(emailIDImageData.buffer.asUint8List());

  final websiteImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_network.png");
  final customerWebsiteImage =
      pw.MemoryImage(websiteImageData.buffer.asUint8List());

  final phoneNoImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_call.png");
  final customerPhoneNoImage =
      pw.MemoryImage(phoneNoImageData.buffer.asUint8List());

  pw.Widget titleText({String? titleText, double? fontSize, PdfColor? color}) {
    return pw.Text(
      titleText ?? "",
      style: pw.TextStyle(
        font: ibmPlexSansw700,
        fontSize: fontSize ?? 16,
        color: color ?? PDFColors.primaryColor,
      ),
    );
  }

  pw.Widget headingText(
      {String? headingText, double? fontSize, PdfColor? color}) {
    return pw.Text(
      headingText ?? "",
      style: pw.TextStyle(
        font: ibmPlexSansw500,
        fontSize: fontSize ?? 14,
        color: color ?? PDFColors.text_color_black,
      ),
    );
  }

  pw.Widget titleSubText(
      {String? titleSubText,
      double? fontSize,
      PdfColor? color,
      pw.TextStyle? style}) {
    return pw.Text(
      titleSubText ?? "",
      style: style ??
          pw.TextStyle(
            font: hind,
            fontSize: fontSize ?? 13,
            color: color ?? PDFColors.text_darkgrey_color,
          ),
    );
  }

  pw.Widget buildUserName() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "${resumeData['customerFirstNametext'] ?? ""} ${resumeData['customerLastNametext'] ?? ""}",
          style: pw.TextStyle(
            font: sourceSerif4w600,
            fontSize: 28,
            color: PDFColors.primaryColor,
          ),
        ),
        pw.Text(
          resumeData['customerProfessiontext'],
          style: pw.TextStyle(
            font: hind,
            color: PDFColors.text_color_black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  pw.Widget buildProfile() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Profile"),
        pw.SizedBox(height: 10),
        pw.SizedBox(
          width: 330,
          child: titleSubText(
              titleSubText: resumeData['customerProfessionalSummarytext']),
        ),
      ],
    );
  }

  pw.Widget buildEducation() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Education"),
        pw.SizedBox(height: 10),
        customerEducationList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerEducationList.length,
                  (index) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      headingText(
                          headingText: customerEducationList[index].university),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: titleSubText(
                                titleSubText:
                                    customerEducationList[index].degree),
                          ),
                          pw.SizedBox(width: kDefaultPadding),
                          titleSubText(
                              titleSubText:
                                  "${customerEducationList[index].startDate} - ${customerEducationList[index].endDate}"),
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

  pw.Widget buildEmployment() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Employment"),
        pw.SizedBox(height: 10),
        customerEmploymentList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerEmploymentList.length,
                  (index) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      headingText(
                          headingText:
                              "${customerEmploymentList[index].jobTitle} at ${customerEmploymentList[index].companyName}"),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            child: titleSubText(
                                titleSubText:
                                    customerEmploymentList[index].address),
                          ),
                          pw.SizedBox(width: kDefaultPadding),
                          titleSubText(
                              titleSubText:
                                  "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
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

  pw.Widget buildOtherDetails() {
    return pw.Container(
      color: PDFColors.lightgray_color,
      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildUserName(),
          pw.SizedBox(height: kDefaultPadding),
          buildProfile(),
          pw.SizedBox(height: kDefaultPadding),
          buildEducation(),
          pw.SizedBox(height: kDefaultPadding),
          buildEmployment(),
        ],
      ),
    );
  }

  pw.Widget builsContactDataField(pw.ImageProvider ic, String details) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.Container(
            height: 14,
            width: 14,
            decoration: pw.BoxDecoration(
              image: pw.DecorationImage(image: ic, fit: pw.BoxFit.contain),
            )),
        pw.SizedBox(width: 10),
        pw.Expanded(
          child: titleSubText(titleSubText: details),
        )
      ],
    );
  }

  pw.Widget buildContacts() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Contacts"),
        pw.SizedBox(height: 10),
        pw.SizedBox(
          width: 260,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              resumeData['customerPhoneNotext'] == ""
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      children: [
                        builsContactDataField(customerPhoneNoImage,
                            resumeData['customerPhoneNotext']),
                        pw.SizedBox(height: 10),
                      ],
                    ),
              resumeData['customerLocationtext'] == ""
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      children: [
                        builsContactDataField(customerLocationImage,
                            resumeData['customerLocationtext']),
                        pw.SizedBox(height: 10),
                      ],
                    ),
              resumeData['customerEmailIDtext'] == ""
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      children: [
                        builsContactDataField(customerEmailIDImage,
                            resumeData['customerEmailIDtext']),
                        pw.SizedBox(height: 10),
                      ],
                    ),
              resumeData['customerWebsitetext'] == ""
                  ? pw.SizedBox.shrink()
                  : builsContactDataField(
                      customerWebsiteImage, resumeData['customerWebsitetext']),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildSkillProgressBar(String skills, double level) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          children: [
            pw.SizedBox(width: 10),
            pw.Container(
              width: 4,
              height: 4,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                color: PDFColors.text_darkgrey_color,
              ),
            ),
            pw.SizedBox(width: 8),
            pw.Expanded(
              child: pw.Text(
                skills,
                style: pw.TextStyle(
                  font: hindw500,
                  fontSize: 13,
                  color: PDFColors.text_color_black,
                ),
              ),
            ),
          ],
        ),
        pw.SizedBox(height: kDefaultPadding / 1.5),
        pw.ClipRRect(
          horizontalRadius: 2.5,
          verticalRadius: 2.5,
          child: pw.SizedBox(
            height: 5,
            child: pw.LinearProgressIndicator(
                value: level / 100.0,
                backgroundColor: PDFColors.lightorengecolor,
                valueColor: PDFColors.primaryColor),
          ),
        ),
        pw.SizedBox(height: kDefaultPadding),
      ],
    );
  }

  pw.Widget buildSkills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Skills"),
        pw.SizedBox(height: kDefaultPadding / 1.5),
        customerSkillList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerSkillList.length,
                  (index) => buildSkillProgressBar(
                      customerSkillList[index].skill,
                      customerSkillList[index].level),
                ),
              ),
      ],
    );
  }

  pw.Widget buildProfileDetails() {
    return pw.Container(
      width: 206,
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: kDefaultPadding),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  pw.Container(
                    height: 145,
                    width: 145,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                          image: profileRingImage, fit: pw.BoxFit.fill),
                    ),
                  ),
                  pw.Container(
                    height: 93,
                    width: 93,
                    decoration: pw.BoxDecoration(
                      shape: pw.BoxShape.circle,
                      image: pw.DecorationImage(
                          image: image, fit: pw.BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: kDefaultPadding),
          buildContacts(),
          pw.SizedBox(height: kDefaultPadding),
          buildSkills(),
        ],
      ),
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (context) {
        return pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: buildOtherDetails(),
            ),
            buildProfileDetails(),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
