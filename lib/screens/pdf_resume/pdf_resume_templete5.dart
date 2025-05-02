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

void pdfResumeTemplete5(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
  final hindSemiw600 = await PDFFonts.hindSemiBold();
  final ibmPlexSansw500 = await PDFFonts.ibmPlexSansSemiBold();
  final ibmPlexSansw700 = await PDFFonts.ibmPlexSansBold();
  final sourceSerif4w600 = await PDFFonts.sourceSerif4SemiBold();

  final locationImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_location.png");
  final customerLocationImage =
      pw.MemoryImage(locationImageData.buffer.asUint8List());

  final emailIDImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_mail.png");
  final customerEmailIDImage =
      pw.MemoryImage(emailIDImageData.buffer.asUint8List());

  final phoneNoImageData =
      await rootBundle.load("${AppImages.ic}ic_filled_call.png");
  final customerPhoneNoImage =
      pw.MemoryImage(phoneNoImageData.buffer.asUint8List());

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

  pw.Widget titleText({String? titleText, double? fontSize, PdfColor? color}) {
    return pw.Text(
      titleText ?? "",
      style: pw.TextStyle(
        font: ibmPlexSansw700,
        fontSize: fontSize ?? 16,
        color: color ?? PDFColors.white_color,
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

  pw.Widget buildbg() {
    return pw.Container(
      width: 190,
      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: pw.BoxDecoration(
        color: PDFColors.primaryColor,
      ),
    );
  }

  pw.Widget buildProfileDetails() {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 196),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            resumeData['customerProfessiontext'] ?? "",
            style: pw.TextStyle(
              font: hind,
              color: PDFColors.text_darkgrey_color,
              fontSize: 14,
            ),
          ),
          pw.SizedBox(height: kTextPadding),
          pw.Text(
            "${resumeData['customerFirstNametext'] ?? ""} ${resumeData['customerLastNametext'] ?? ""}",
            style: pw.TextStyle(
                font: sourceSerif4w600,
                fontSize: 25,
                color: PDFColors.text_color_black),
          ),
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
    return pw.Stack(
      alignment: pw.Alignment.topLeft,
      children: [
        titleText(titleText: "Contacts"),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 196),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              resumeData['customerPhoneNotext'] == ""
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
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
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildProfile() {
    return pw.Stack(
      alignment: pw.Alignment.topLeft,
      children: [
        titleText(titleText: "Profile"),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 196),
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
                  (index) => pw.Stack(
                    alignment: pw.Alignment.topLeft,
                    children: [
                      pw.Text(
                        "${customerEducationList[index].startDate} - ${customerEducationList[index].endDate}",
                        style: pw.TextStyle(
                          font: hind,
                          fontSize: 13,
                          color: PDFColors.white_color,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 196),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            headingText(
                                headingText:
                                    customerEducationList[index].university),
                            pw.SizedBox(height: kTextPadding),
                            titleSubText(
                                titleSubText:
                                    customerEducationList[index].degree),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      ),
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
                  (index) => pw.Stack(
                    alignment: pw.Alignment.topLeft,
                    children: [
                      pw.Text(
                        "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}",
                        style: pw.TextStyle(
                          font: hind,
                          fontSize: 13,
                          color: PDFColors.white_color,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 196),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            headingText(
                                headingText:
                                    "${customerEmploymentList[index].jobTitle} at ${customerEmploymentList[index].companyName}"),
                            pw.SizedBox(height: kTextPadding),
                            titleSubText(
                                titleSubText:
                                    customerEmploymentList[index].address),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  pw.Widget buildSkills() {
    return pw.Stack(
      alignment: pw.Alignment.topLeft,
      children: [
        titleText(titleText: "Skills"),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 196),
          child: pw.Row(
            children: [
              customerSkillList.isEmpty
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: List.generate(
                        customerSkillList.length,
                        (index) => pw.SizedBox(
                            width: 177,
                            child: pw.Text(
                              customerSkillList[index].skill,
                              style: pw.TextStyle(
                                font: hindSemiw600,
                                fontSize: 13,
                                color: PDFColors.black_color,
                              ),
                            )),
                      ),
                    ),
              pw.SizedBox(width: kDefaultPadding * 5),
              customerSkillList.isEmpty
                  ? pw.SizedBox.shrink()
                  : pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: List.generate(
                        customerSkillList.length,
                        (index) => titleSubText(
                            titleSubText: customerSkillList[index].level == 20
                                ? "Beginner"
                                : customerSkillList[index].level == 40
                                    ? "Moderate"
                                    : customerSkillList[index].level == 60
                                        ? "Good"
                                        : customerSkillList[index].level == 80
                                            ? "Very good"
                                            : customerSkillList[index].level ==
                                                    100
                                                ? "Expert"
                                                : "Make a choice"),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget buildDetails() {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
          horizontal: 22, vertical: kDefaultPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildProfileDetails(),
          pw.SizedBox(height: kDefaultPadding),
          buildContacts(),
          pw.SizedBox(height: kDefaultPadding),
          buildProfile(),
          pw.SizedBox(height: kDefaultPadding),
          buildEducation(),
          pw.SizedBox(height: kDefaultPadding),
          buildEmployment(),
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
        return pw.Stack(
          children: [
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildbg(),
              ],
            ),
            buildDetails(),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
