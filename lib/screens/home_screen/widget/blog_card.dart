import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';

class BuildBlogCard extends StatefulWidget {
  final String blogImage;
  final String blogTitle;
  final String blogDescription;
  const BuildBlogCard(
      {super.key,
      required this.blogImage,
      required this.blogTitle,
      required this.blogDescription});

  @override
  State<BuildBlogCard> createState() => _BuildBlogCardState();
}

class _BuildBlogCardState extends State<BuildBlogCard> {
  bool _isHovering = false;

  void _mouseEnter(bool hover) {
    setState(() {
      _isHovering = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(kDefaultPadding),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white_color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          if (_isHovering ||
              (kIsWeb
                  ? false
                  : MediaQuery.of(context).size.width <= kScreenWidthSm))
            BoxShadow(
              offset: Offset.zero,
              color: AppColors.black_color.withOpacity(0.16),
              blurRadius: 4,
              spreadRadius: 0,
            ),
        ],
      ),
      child: MouseRegion(
        onEnter: (event) => _mouseEnter(true),
        onExit: (event) => _mouseEnter(false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: _isHovering
                ? LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.65)
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.white_color,
                      AppColors.white_color.withOpacity(0.65)
                    ],
                  ),
          ),
          child: Column(
            children: [
              Image.asset(widget.blogImage),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 20
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 70
                            : 20,
                    vertical: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 20
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 70
                            : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: widget.blogTitle,
                      color: _isHovering
                          ? AppColors.white_color
                          : AppColors.text_color_black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 28
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 50
                              : 28,
                      fontWeight: FontWeight.w500,
                    ),
                    buildSizedBoxH(kDefaultPadding),
                    AppText(
                      text: widget.blogDescription,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 20
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 70
                              : 20,
                      color: _isHovering
                          ? AppColors.white_color
                          : AppColors.gray_color,
                      maxLines:
                          MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? 5
                              : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    buildSizedBoxH(MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? kDefaultPadding * 1.5
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 58
                            : kDefaultPadding * 1.5),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).go(RouteUri.blogDetails);

                        window.localStorage['BLOGPOSTTITLE'] = widget.blogTitle;
                        window.localStorage['BLOGPOSTIMAGE'] = widget.blogImage;
                        setState(() {});
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              text: "View Post",
                              fontsize: MediaQuery.of(context).size.width <=
                                      kScreenWidthLg
                                  ? 18
                                  : MediaQuery.of(context).size.width <=
                                          kScreenWidthXxl
                                      ? MediaQuery.of(context).size.width / 77.7
                                      : 18,
                              color: _isHovering
                                  ? AppColors.white_color
                                  : AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                            ),
                            Icon(Icons.arrow_outward_rounded,
                                color: _isHovering
                                    ? AppColors.white_color
                                    : AppColors.primaryColor,
                                size: MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? 20
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width / 70
                                        : 20)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
