import 'package:flutter/material.dart';
import 'package:quick_resume_creator/core/animations/entrance_fader.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';

class PublicMasterLayout extends StatelessWidget {
  final Widget body;

  const PublicMasterLayout({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_color,
      body: EntranceFader(
        offset: const Offset(0, 0),
        delay: const Duration(milliseconds: 16),
        duration: const Duration(milliseconds: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
