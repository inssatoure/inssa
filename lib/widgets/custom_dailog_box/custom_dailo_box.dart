// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';

class CustomDialog extends StatefulWidget {
  final String? imagePath;
  final String message;
  final String? positiveButtonText;
  final String? negativeButtonText;
  void Function() onpositivePressed;

  CustomDialog({
    super.key,
    this.imagePath,
    required this.message,
    this.positiveButtonText,
    this.negativeButtonText,
    required this.onpositivePressed,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultPadding),
      ),
      title: headingText(widget.message),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  _isProcessing = true;
                });

                widget.onpositivePressed();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.primaryColor),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _isProcessing
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: AppColors.white_color,
                            strokeWidth: 2.5,
                          ))
                      : Text(
                          widget.positiveButtonText ?? "Ok",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.white_color),
                        ),
                ),
              )),
        ),
        buildSizedBoxW(kDefaultPadding),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: _isProcessing
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            color: AppColors.white_color,
                            strokeWidth: 2.5,
                          ))
                      : Text(
                          widget.negativeButtonText ?? "Cancel",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColors.primaryColor),
                        ),
                ),
              )),
        )
      ],
    );
  }

  Widget headingText(String headingText,
      [double? fontSize, Color? color, FontWeight? fontWeight]) {
    return Text(
      headingText,
      style: GoogleFonts.jost(
        fontSize: fontSize ?? 16,
        color: color ?? AppColors.text_color_black,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
