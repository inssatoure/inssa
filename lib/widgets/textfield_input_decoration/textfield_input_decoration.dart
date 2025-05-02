import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';

class CustomAppTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final Function()? onTap;
  final Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Function(String?)? onFieldSubmitted;

  const CustomAppTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.controller,
      this.keyboardType,
      this.obscureText,
      this.maxLength,
      this.maxLines,
      this.onTap,
      this.onChanged,
      this.inputFormatters,
      this.validator,
      this.readOnly,
      this.focusNode,
      this.suffixIcon,
      this.onFieldSubmitted});

  @override
  State<CustomAppTextField> createState() => _CustomAppTextFieldState();
}

class _CustomAppTextFieldState extends State<CustomAppTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.labelText!,
      cursorColor: AppColors.black_color.withOpacity(0.5),
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly ?? false,
      decoration: buildInputDecoration(
          labelText: widget.labelText, suffixIcon: widget.suffixIcon),
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText ?? false,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enableSuggestions: false,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      validator: widget.validator ??
          FormBuilderValidators.compose([FormBuilderValidators.required()]),
      onSubmitted: widget.onFieldSubmitted,
    );
  }
}

InputDecoration buildInputDecoration({String? labelText, Widget? suffixIcon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(
      left: kDefaultPadding,
      right: kDefaultPadding,
      top: kDefaultPadding / 2,
      bottom: kDefaultPadding / 2,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.error_color.withOpacity(0.5)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.error_color.withOpacity(0.5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.black_color.withOpacity(0.5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.black_color.withOpacity(0.5)),
    ),
    labelText: labelText == "" ? "" : " $labelText ",
    labelStyle: TextStyle(
      fontSize: kDefaultPadding,
      fontFamily: GoogleFonts.jost().fontFamily,
      fontWeight: FontWeight.w500,
      color: AppColors.text_color_black,
    ),
    suffixIcon: suffixIcon,
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}
