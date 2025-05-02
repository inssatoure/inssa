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

void pdfResumeTemplete4(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
  final ibmPlexSansw500 = await PDFFonts.ibmPlexSansSemiBold();
  final ibmPlexSansw700 = await PDFFonts.ibmPlexSansBold();
  final sourceSerif4w600 = await PDFFonts.sourceSerif4SemiBold();

  const summaryCardCrossAxisCount = 3;

  final response =
      await http.get(Uri.parse(resumeData['customerProfileImage'] ?? ""));

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

  pw.Widget profile() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText(titleText: "Profile"),
          pw.SizedBox(height: 7),
          titleSubText(
              titleSubText: resumeData['customerProfessionalSummarytext']),
        ]);
  }

  pw.Widget contacts() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Contacts"),
        pw.SizedBox(height: 7),
        pw.SizedBox(
          width: 205,
          child: pw.Column(children: [
            resumeData['customerPhoneNotext'] != ""
                ? pw.Row(children: [
                    pw.Container(
                        height: 14,
                        width: 14,
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: customerPhoneNoImage,
                              fit: pw.BoxFit.contain),
                        )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: titleSubText(
                          titleSubText: resumeData['customerPhoneNotext']),
                    )
                  ])
                : pw.SizedBox.shrink(),
            resumeData['customerLocationtext'] != ""
                ? pw.Row(children: [
                    pw.Container(
                        height: 14,
                        width: 14,
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: customerLocationImage,
                              fit: pw.BoxFit.contain),
                        )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: titleSubText(
                          titleSubText: resumeData['customerLocationtext']),
                    )
                  ])
                : pw.SizedBox.shrink(),
            resumeData['customerEmailIDtext'] != ""
                ? pw.Row(children: [
                    pw.Container(
                        height: 14,
                        width: 14,
                        padding: const pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: customerEmailIDImage,
                              fit: pw.BoxFit.contain),
                        )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: titleSubText(
                          titleSubText: resumeData['customerEmailIDtext']),
                    )
                  ])
                : pw.SizedBox.shrink(),
            resumeData['customerWebsitetext'] != ""
                ? pw.Row(children: [
                    pw.Container(
                        height: 14,
                        width: 14,
                        decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: customerWebsiteImage,
                              fit: pw.BoxFit.contain),
                        )),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: titleSubText(
                          titleSubText: resumeData['customerWebsitetext']),
                    )
                  ])
                : pw.SizedBox.shrink(),
          ]),
        )
      ],
    );
  }

  pw.Widget skills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        headingText(headingText: "Skills", color: PDFColors.white_color),
        pw.SizedBox(height: 7),
        customerSkillList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.SizedBox(
                width: double.infinity,
                child: pw.LayoutBuilder(
                  builder: (context, constraints) {
                    final summaryCardWidth = ((constraints!.maxWidth -
                                (kDefaultPadding *
                                    (summaryCardCrossAxisCount - 1))) /
                            summaryCardCrossAxisCount -
                        kDefaultPadding);
                    return pw.Wrap(
                      alignment: pw.WrapAlignment.spaceBetween,
                      children: List.generate(
                        customerSkillList.length,
                        (index) => pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              customerSkillList[index].skill,
                              style: pw.TextStyle(
                                  color: PDFColors.text_color_black),
                            ),
                            pw.SizedBox(height: kDefaultPadding / 1.5),
                            pw.ClipRRect(
                              horizontalRadius: 2.5,
                              verticalRadius: 2.5,
                              child: pw.SizedBox(
                                height: 5,
                                width: summaryCardWidth,
                                child: pw.LinearProgressIndicator(
                                    value:
                                        customerSkillList[index].level / 100.0,
                                    backgroundColor: PDFColors.lightorengecolor,
                                    valueColor: PDFColors.primaryColor),
                              ),
                            ),
                            pw.SizedBox(height: kDefaultPadding),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
      ],
    );
  }

  pw.Widget education() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText(titleText: "Education"),
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
                          children: [
                            titleSubText(
                                titleSubText:
                                    "${customerEducationList[index].startDate} - ${customerEducationList[index].endDate}"),
                            pw.SizedBox(width: 20),
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  headingText(
                                      headingText: customerEducationList[index]
                                          .university),
                                  pw.SizedBox(height: kTextPadding),
                                  titleSubText(
                                      titleSubText:
                                          customerEducationList[index].degree)
                                ],
                              ),
                            )
                          ],
                        ),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              : pw.SizedBox.shrink(),
        ]);
  }

  pw.Widget employment() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Employment"),
        pw.SizedBox(height: 8),
        customerEmploymentList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                children: List.generate(
                  customerEmploymentList.length,
                  (index) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          titleSubText(
                              titleSubText:
                                  "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
                          pw.SizedBox(width: 20),
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                headingText(
                                    headingText:
                                        "${customerEmploymentList[index].jobTitle} at ${customerEmploymentList[index].companyName}"),
                                pw.SizedBox(height: kTextPadding),
                                titleSubText(
                                    titleSubText:
                                        customerEmploymentList[index].address)
                              ],
                            ),
                          )
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
      width: double.infinity,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(child: profile()),
          pw.SizedBox(width: kDefaultPadding),
          contacts(),
        ],
      ),
    );
  }

  pw.Widget buildProfileAndUsername() {
    return pw.Container(
      width: double.infinity,
      color: PDFColors.lightorengecolor,
      padding: const pw.EdgeInsets.all(kDefaultPadding),
      child: pw.Column(
        children: [
          pw.Container(
            height: 93,
            width: 93,
            decoration: pw.BoxDecoration(
              shape: pw.BoxShape.circle,
              image: pw.DecorationImage(image: image, fit: pw.BoxFit.cover),
            ),
          ),
          pw.SizedBox(height: kDefaultPadding / 1.5),
          pw.Text(
            "${resumeData['customerFirstNametext'] ?? ""} ${resumeData['customerLastNametext'] ?? ""}",
            style: pw.TextStyle(
              font: sourceSerif4w600,
              color: PDFColors.primaryColor,
              fontSize: 26,
            ),
          ),
          pw.SizedBox(height: kTextPadding),
          pw.Text(
            resumeData['customerProfessiontext'] ?? "",
            style: const pw.TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      build: (context) {
        return pw.Column(
          children: [
            buildProfileAndUsername(),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 27),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  buildOtherDetails(),
                  pw.SizedBox(height: kTextPadding),
                  education(),
                  pw.SizedBox(height: kTextPadding),
                  employment(),
                  pw.SizedBox(height: kTextPadding),
                  skills(),
                  pw.SizedBox(height: kTextPadding),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
