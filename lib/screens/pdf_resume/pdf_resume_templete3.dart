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

void pdfResumeTemplete3(Map<String, dynamic> resumeData) async {
  final pdf = pw.Document();

  final hind = await PDFFonts.hind();
  final ibmPlexSansw500 = await PDFFonts.ibmPlexSansSemiBold();
  final sourceSerif4w600 = await PDFFonts.sourceSerif4SemiBold();

  final response =
      await http.get(Uri.parse(resumeData['customerProfileImage'] ?? ""));

  final locationImageData =
      await rootBundle.load("${AppImages.ic}ic_location.png");
  final customerLocationImage =
      pw.MemoryImage(locationImageData.buffer.asUint8List());

  final emailIDImageData = await rootBundle.load("${AppImages.ic}ic_mail.png");
  final customerEmailIDImage =
      pw.MemoryImage(emailIDImageData.buffer.asUint8List());

  final websiteImageData =
      await rootBundle.load("${AppImages.ic}ic_network.png");
  final customerWebsiteImage =
      pw.MemoryImage(websiteImageData.buffer.asUint8List());

  final phoneNoImageData = await rootBundle.load("${AppImages.ic}ic_call.png");
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
    return pw.Container(
      height: 40,
      width: 150,
      decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PDFColors.text_color_black, width: 0.8)),
      child: pw.Center(
        child: pw.Text(
          titleText ?? "",
          style: pw.TextStyle(
            font: ibmPlexSansw500,
            fontSize: fontSize ?? 16,
            color: color ?? PDFColors.primaryColor,
          ),
        ),
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
        resumeData['customerPhoneNotext'] != ""
            ? pw.Row(children: [
                pw.Container(
                    height: 14,
                    width: 14,
                    decoration: pw.BoxDecoration(
                      image: pw.DecorationImage(
                          image: customerPhoneNoImage, fit: pw.BoxFit.contain),
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
                          image: customerLocationImage, fit: pw.BoxFit.contain),
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
                          image: customerEmailIDImage, fit: pw.BoxFit.contain),
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
                          image: customerWebsiteImage, fit: pw.BoxFit.contain),
                    )),
                pw.SizedBox(width: 10),
                pw.Expanded(
                  child: titleSubText(
                      titleSubText: resumeData['customerWebsitetext']),
                )
              ])
            : pw.SizedBox.shrink(),
      ],
    );
  }

  pw.Widget skills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText(titleText: "Key Skills"),
        pw.SizedBox(height: 7),
        customerSkillList.isEmpty
            ? pw.SizedBox.shrink()
            : pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: List.generate(
                  customerSkillList.length,
                  (index) => pw.Row(children: [
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
                        customerSkillList[index].skill,
                        maxLines: 1,
                        style: pw.TextStyle(
                          color: PDFColors.text_darkgrey_color,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ]),
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
                        headingText(
                            headingText:
                                customerEducationList[index].university),
                        pw.SizedBox(height: kTextPadding + 1),
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
                )
              : pw.SizedBox.shrink(),
        ]);
  }

  pw.Widget employment() {
    return pw.Expanded(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          titleText(titleText: "Employment"),
          pw.SizedBox(height: 7),
          customerEmploymentList.isNotEmpty
              ? pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: List.generate(
                    customerEmploymentList.length,
                    (index) => pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Expanded(
                              child: headingText(
                                  headingText:
                                      "${customerEmploymentList[index].jobTitle} at ${customerEmploymentList[index].companyName}"),
                            ),
                            pw.SizedBox(width: kDefaultPadding),
                            titleSubText(
                                titleSubText:
                                    "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
                          ],
                        ),
                        pw.SizedBox(height: kTextPadding + 1),
                        titleSubText(
                            titleSubText:
                                customerEmploymentList[index].address),
                        pw.SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
              : pw.SizedBox.shrink(),
        ],
      ),
    );
  }

  pw.Widget position() {
    return pw.Column(children: [
      titleText(titleText: "Position"),
      pw.SizedBox(height: 7),
      pw.Text(
        resumeData['customerProfessiontext'].toString(),
        style: pw.TextStyle(font: hind, fontSize: 13),
      ),
    ]);
  }

  pw.Widget buildProfileDetails() {
    return pw.Container(
      width: 179,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
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
            "${resumeData['customerFirstNametext']} ${resumeData['customerLastNametext']}",
            style: pw.TextStyle(
              font: sourceSerif4w600,
              fontSize: 26,
            ),
          ),
          pw.SizedBox(height: kDefaultPadding * 1.5),
          position(),
          pw.SizedBox(height: kDefaultPadding * 1.5),
          contacts(),
          pw.SizedBox(height: kDefaultPadding * 1.5),
          skills(),
          pw.SizedBox(height: kDefaultPadding * 1.5),
        ],
      ),
    );
  }

  pw.Widget buildOtherDetails() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        profile(),
        pw.SizedBox(height: kDefaultPadding),
        education(),
        pw.SizedBox(height: kDefaultPadding),
        employment(),
      ],
    );
  }

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      build: (context) {
        return pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildProfileDetails(),
            pw.SizedBox(width: kDefaultPadding),
            pw.Expanded(
              child: buildOtherDetails(),
            ),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
