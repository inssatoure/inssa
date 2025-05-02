import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/pdf/pdf_colors/app_pdf_colors.dart';
import 'package:quick_resume_creator/core/pdf/pdf_fonts/app_pdf_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:quick_resume_creator/models/education.dart';
import 'package:quick_resume_creator/models/employment.dart';
import 'package:quick_resume_creator/models/personal_skill.dart';
import 'package:quick_resume_creator/models/professional_skill.dart';

void pdfResumeTemplete1(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
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

  List<ProfessionalSkill> customerProfessionalSkillList =
      (resumeData['customerProfessionalSkillList'] as List)
          .map((e) => ProfessionalSkill.fromJson(e))
          .toList();

  List<PersonalSkill> customerPersonalSkillList =
      (resumeData['customerPersonalSkillList'] as List)
          .map((e) => PersonalSkill.fromJson(e))
          .toList();

  final Uint8List networkImage = response.bodyBytes;

  final image = pw.MemoryImage(networkImage);

  pw.Widget titleText(String titleText) {
    return pw.Text(
      titleText,
      style: pw.TextStyle(
        font: ibmPlexSansw700,
        fontSize: 15,
        color: PDFColors.primaryColor,
      ),
    );
  }

  pw.Widget headingText(String headingText,
      [double? fontSize, PdfColor? color]) {
    return pw.Text(
      headingText,
      style: pw.TextStyle(
        font: ibmPlexSansw500,
        fontSize: fontSize ?? 13,
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
            fontSize: fontSize ?? 12,
            color: color ?? PDFColors.text_darkgrey_color,
          ),
    );
  }

  pw.Widget profile() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText("Profile"),
          pw.SizedBox(height: 7),
          titleSubText(resumeData['customerProfessionalSummarytext']),
        ]);
  }

  pw.Widget education() {
    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      titleText("Education"),
      pw.SizedBox(height: 7),
      customerEducationList.isNotEmpty
          ? pw.Column(
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
                            pw.SizedBox(height: 5),
                            titleSubText(
                                customerEducationList[index].startDate),
                            pw.SizedBox(height: 5),
                            titleSubText("-"),
                            pw.SizedBox(height: 2),
                            titleSubText(customerEducationList[index].endDate),
                          ],
                        ),
                        pw.SizedBox(width: 17),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              headingText(
                                  customerEducationList[index].university),
                              pw.SizedBox(height: 5),
                              titleSubText(customerEducationList[index].degree)
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 7),
                  ],
                ),
              ),
            )
          : pw.SizedBox.shrink(),
    ]);
  }

  pw.Widget keySkills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText("Key Skills"),
        pw.SizedBox(height: 5),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 8),
                  headingText("Professional"),
                  pw.SizedBox(height: 5),
                  customerProfessionalSkillList.isEmpty
                      ? pw.SizedBox.shrink()
                      : pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(
                            customerProfessionalSkillList.length,
                            (index) => pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4),
                              child: titleSubText(
                                  customerProfessionalSkillList[index]
                                      .professionalSkill),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            pw.SizedBox(width: 8),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 8),
                  headingText("Personal"),
                  pw.SizedBox(height: 5),
                  customerPersonalSkillList.isEmpty
                      ? pw.SizedBox.shrink()
                      : pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(
                            customerPersonalSkillList.length,
                            (index) => pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4),
                              child: titleSubText(
                                  customerPersonalSkillList[index]
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

  pw.Widget employment() {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: kDefaultPadding),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText("Employment"),
          pw.SizedBox(height: 8),
          customerEmploymentList.isEmpty
              ? pw.SizedBox.shrink()
              : pw.Column(
                  children: List.generate(
                    customerEmploymentList.length,
                    (index) => pw.Column(
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
                                    customerEmploymentList[index].startDate),
                                pw.SizedBox(height: kTextPadding),
                                titleSubText("-"),
                                pw.SizedBox(height: 2),
                                titleSubText(
                                    customerEmploymentList[index].endDate),
                              ],
                            ),
                            pw.SizedBox(width: 18),
                            pw.Expanded(
                              child: pw.Column(
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
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Container(
                      height: 93,
                      width: 93,
                      decoration: pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        image: pw.DecorationImage(
                            image: image, fit: pw.BoxFit.cover),
                      ),
                    ),
                    pw.SizedBox(width: kDefaultPadding),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "${resumeData['customerFirstNametext'] ?? ""}\n${resumeData['customerLastNametext'] ?? ""}",
                          style: pw.TextStyle(
                            font: sourceSerif4w600,
                            fontSize: 23,
                            color: PDFColors.text_color_black,
                          ),
                        ),
                        pw.Text(
                          resumeData['customerProfessiontext'].toString(),
                          style: pw.TextStyle(
                              font: hind,
                              fontSize: 12,
                              color: PDFColors.text_color_black),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  width: 205,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      resumeData['customerLocationtext'] != ""
                          ? titleSubText(
                              resumeData['customerLocationtext'].toString())
                          : pw.SizedBox.shrink(),
                      resumeData['customerWebsitetext'] != ""
                          ? titleSubText(
                              resumeData['customerWebsitetext'].toString())
                          : pw.SizedBox.shrink(),
                      resumeData['customerEmailIDtext'] != ""
                          ? titleSubText(
                              resumeData['customerEmailIDtext'].toString())
                          : pw.SizedBox.shrink(),
                      resumeData['customerPhoneNotext'] != ""
                          ? titleSubText(
                              resumeData['customerPhoneNotext'].toString())
                          : pw.SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: kDefaultPadding),
            pw.Divider(),
            pw.SizedBox(height: kDefaultPadding),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      profile(),
                      pw.SizedBox(height: kDefaultPadding),
                      education(),
                      pw.SizedBox(height: kDefaultPadding),
                      keySkills(),
                    ],
                  ),
                ),
                pw.Expanded(child: employment())
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
