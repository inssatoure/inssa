// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/widgets/custom_image_view/custom_image_view.dart';

class CustomVerticalDialog extends StatefulWidget {
  final String imagePath;
  final String message;
  final String? positiveButtonText;
  final String? negativeButtonText;
  void Function() onpositivePressed;

  CustomVerticalDialog({
    super.key,
    required this.imagePath,
    required this.message,
    this.positiveButtonText,
    this.negativeButtonText,
    required this.onpositivePressed,
  });

  @override
  State<CustomVerticalDialog> createState() => _CustomVerticalDialogState();
}

class _CustomVerticalDialogState extends State<CustomVerticalDialog> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.inv_indexblue_color,
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white_color,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.light_blue.withOpacity(0.09),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: MediaQuery.of(context).size.height / 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomImageView(
                            imagePath: widget.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(widget.message,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  height: 1.5)),
                          buildSizedBoxH(44),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
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
                                ),
                              ),
                              buildSizedBoxW(15),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white_color,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.button_shadow_blue
                                          .withOpacity(0.25),
                                      blurRadius: 11.17,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: Text(
                                      widget.negativeButtonText ?? "Cancel",
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: AppColors.inv_indexblue_color),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
