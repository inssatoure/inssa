import 'package:flutter/material.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';

class CreateYourResumeButton extends StatefulWidget {
  const CreateYourResumeButton({super.key});

  @override
  State<CreateYourResumeButton> createState() => _CreateYourResumeButtonState();
}

class _CreateYourResumeButtonState extends State<CreateYourResumeButton>
    with SingleTickerProviderStateMixin {
  bool _isCreateYourResumeButtonHovered = false;

  late AnimationController _container;
  late Animation _animation;

  void _mouseEnterCreateYourResumeButton(bool hover) {
    setState(() {
      _isCreateYourResumeButtonHovered = hover;

      if (hover) {
        _container.forward();
      } else {
        _container.reverse();
      }
    });
  }

  @override
  void initState() {
    _container = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    _animation = Tween(begin: 0.0, end: 500)
        .animate(CurvedAnimation(parent: _container, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _mouseEnterCreateYourResumeButton(true),
      onExit: (event) => _mouseEnterCreateYourResumeButton(false),
      cursor: SystemMouseCursors.click,
      child: Container(
        height: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? MediaQuery.of(context).size.width / 7.2
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width / 12.4
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 17.5
                    : 80,
        width: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? MediaQuery.of(context).size.width / 1.3
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width / 1.9
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 2.8
                    : 500,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 48
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 35
                      : 48),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              color: AppColors.primaryColor.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: _animation.value,
                decoration: BoxDecoration(
                  color: AppColors.white_color,
                  border: Border.all(color: AppColors.white_color),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width <= kScreenWidthLg
                          ? 48
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 35
                              : 48),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: AppText(
                  key: UniqueKey(),
                  text: "Create Your Resume",
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 26
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 48
                          : 36,
                  fontWeight: FontWeight.w400,
                  color: _isCreateYourResumeButtonHovered
                      ? AppColors.primaryColor
                      : AppColors.white_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
