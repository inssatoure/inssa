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

void pdfResumeTemplete8(Map<String, dynamic> resumeData) async {
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

  List<Skill> customerSkillList = (resumeData['customerSkillList'] as List)
      .map((e) => Skill.fromJson(e))
      .toList();

  final Uint8List networkImage = response.bodyBytes;
  final image = pw.MemoryImage(networkImage);

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

  pw.Widget titleText(String titleText) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          titleText,
          style: pw.TextStyle(
            font: ibmPlexSansw700,
            fontSize: 18,
            color: PDFColors.black_color,
          ),
        ),
        pw.SizedBox(height: 7),
        pw.Container(
          height: 2,
          width: 30,
          color: PDFColors.primaryColor,
        ),
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
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText("Education"),
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
                          pw.Expanded(
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                titleSubText(
                                    "${customerEducationList[index].startDate} - ${customerEducationList[index].endDate}"),
                                pw.SizedBox(height: kTextPadding),
                                headingText(
                                    customerEducationList[index].university),
                                pw.SizedBox(height: kTextPadding),
                                titleSubText(
                                    customerEducationList[index].degree)
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

  pw.Widget keySkills() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText("Key Skills"),
        pw.SizedBox(height: 5),
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
                                  shape: pw.BoxShape.circle)),
                          pw.SizedBox(width: 8),
                          pw.Expanded(
                            child: pw.Text(
                              customerSkillList[index].skill,
                              style: pw.TextStyle(
                                color: PDFColors.text_darkgrey_color,
                                fontSize: 13,
                              ),
                            ),
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

  pw.Widget employment() {
    return pw.Column(
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
                          titleSubText(
                              "${customerEmploymentList[index].startDate} - ${customerEmploymentList[index].endDate}"),
                          pw.SizedBox(width: 20),
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
                      pw.SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
      ],
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
          child: titleSubText(details),
        )
      ],
    );
  }

  pw.Widget buildContacts() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        titleText("Contacts"),
        pw.SizedBox(height: 10),
        pw.Column(
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
                : pw.Column(
                    children: [
                      builsContactDataField(customerWebsiteImage,
                          resumeData['customerWebsitetext']),
                      pw.SizedBox(height: 10),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  pw.Widget profileColumn() {
    return pw.SizedBox(
        width: 213,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            education(),
            pw.SizedBox(height: kDefaultPadding),
            buildContacts(),
            pw.SizedBox(height: kDefaultPadding),
            keySkills(),
          ],
        ));
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
              children: [
                pw.SizedBox(width: 10),
                pw.Container(
                  height: 93,
                  width: 93,
                  decoration: pw.BoxDecoration(
                    shape: pw.BoxShape.circle,
                    image:
                        pw.DecorationImage(image: image, fit: pw.BoxFit.cover),
                  ),
                ),
                pw.SizedBox(width: 20),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "${resumeData['customerFirstNametext']} ${resumeData['customerLastNametext']}",
                      style: pw.TextStyle(
                        font: sourceSerif4w600,
                        fontSize: 23,
                        color: PDFColors.primaryColor,
                      ),
                    ),
                    pw.Text(
                      resumeData['customerProfessiontext'],
                      style: pw.TextStyle(
                        font: hind,
                        color: PDFColors.text_color_black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: kDefaultPadding * 2),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                profileColumn(),
                pw.SizedBox(width: kDefaultPadding),
                pw.Expanded(
                    child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    profile(),
                    pw.SizedBox(height: kDefaultPadding),
                    employment(),
                  ],
                )),
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'resume.pdf');
}
