import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildBlogDetailsScreen extends StatefulWidget {
  const BuildBlogDetailsScreen({super.key});

  @override
  State<BuildBlogDetailsScreen> createState() => _BuildBlogDetailsScreenState();
}

class _BuildBlogDetailsScreenState extends State<BuildBlogDetailsScreen> {
  final ScrollController scrollController = ScrollController();

  late String blogTitle = "";
  late String blogImage = "";

  @override
  void initState() {
    blogTitle = window.localStorage['BLOGPOSTTITLE'].toString();
    blogImage = window.localStorage['BLOGPOSTIMAGE'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PortalMasterLayout(
      selectedIndex: 4,
      scrollController: scrollController,
      body: Column(
        children: [
          Divider(color: AppColors.dividercolor, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? MediaQuery.of(context).size.width / 12.4
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : kDefaultPadding * 5),
                _buildBlogTitle(blogTitle),
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? MediaQuery.of(context).size.width / 10.33
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 14.58
                            : kDefaultPadding * 6),
                _buildBlogImage(blogImage),
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? kDefaultPadding * 2
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 29.1
                            : kDefaultPadding * 3),
                _buildBlogDetails(),
                buildSizedBoxH(
                    MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? kDefaultPadding * 2
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 29.1
                            : kDefaultPadding * 3),
              ],
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.1
                  : kDefaultPadding * 3),
          footer(),
        ],
      ),
    );
  }

  Widget _buildBlogTitle(String blogTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          AppText(
            text: "Blogs",
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 16
                : 48,
            fontWeight: FontWeight.w700,
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 62
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 87.5
                  : kDefaultPadding),
          AppText(
            text: blogTitle,
            textCenter: true,
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
                ? MediaQuery.of(context).size.width / 26.2
                : 30,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildBlogImage(String blogImage) {
    return MediaQuery.of(context).size.width <= kScreenWidthMd
        ? Image.asset(blogImage)
        : Image.asset(blogImage, height: 500);
  }

  Widget _buildBlogDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 0
              : kDefaultPadding * 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text:
                "Getting your resume noticed by potential employers starts with how you send it. Crafting the perfect email that accompanies your resume is as important as the resume itself. The way you present yourself in this initial contact can make all the difference in securing an interview.",
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 20
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 70
                    : 20,
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.1
                  : kDefaultPadding * 3),
          _buildThePerfectCreativity(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.1
                  : kDefaultPadding * 3),
          _buildHighlightNote(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.1
                  : kDefaultPadding * 3),
          _buildOtherDetails(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.1
                  : kDefaultPadding * 3),
          _buildBlogProfile(),
        ],
      ),
    );
  }

  Widget _buildThePerfectCreativity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          text: "The Perfect Creativity",
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          textCenter: true,
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 30
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 46.66
                  : 30,
        ),
        buildSizedBoxH(kDefaultPadding),
        AppText(
          text:
              "Appropriately tailor your email message to make it clear and professional. Begin with a concise subject line that clearly indicates the purpose of your email. Address the recipient by their proper title and ensure the body of the email is direct and to the point.",
          textCenter: true,
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 20
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 70
                  : 20,
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding * 2
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 29.1
                : kDefaultPadding * 3),
        _buildThePerfectCreativityBulletPoints("Use a formal greeting"),
        buildSizedBoxH(kDefaultPadding / 1.5),
        _buildThePerfectCreativityBulletPoints(
            "Begin with an engaging opening"),
        buildSizedBoxH(kDefaultPadding / 1.5),
        _buildThePerfectCreativityBulletPoints(
            "Clearly state the purpose of your email"),
        buildSizedBoxH(kDefaultPadding / 1.5),
        _buildThePerfectCreativityBulletPoints(
            "Mention the position you're applying for"),
      ],
    );
  }

  Widget _buildThePerfectCreativityBulletPoints(String bulletPoints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 8
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 145
                  : 8,
        ),
        AppText(
          text: " $bulletPoints",
          textCenter: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 20
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 70
                  : 20,
        ),
      ],
    );
  }

  Widget _buildHighlightNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding * 2),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: AppText(
        text:
            '"The first step to getting noticed is making sure your email gets opened."',
        textCenter: true,
        color: AppColors.white_color,
        fontWeight: FontWeight.w500,
        fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
            ? 25
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 56
                : 25,
      ),
    );
  }

  Widget _buildOtherDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: "Get the details right",
          textCenter: true,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 30
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 46.66
                  : 30,
        ),
        buildSizedBoxH(kDefaultPadding),
        AppText(
          text:
              "Appropriately tailor your email message to make it clear and professional. Begin with a concise subject line that clearly indicates the purpose of your email. Address the recipient by their proper title and ensure the body of the email is direct and to the point.",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 20
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 70
                  : 20,
        ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding * 2
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 43.75
                : kDefaultPadding * 2),
        _buildOtherDetailsBulletPoints(
            "1. Customize your email for each job application"),
        buildSizedBoxH(kDefaultPadding / 1.5),
        _buildOtherDetailsBulletPoints(
            "2. Proofread before sending to avoid any mistakes"),
        buildSizedBoxH(kDefaultPadding / 1.5),
        _buildOtherDetailsBulletPoints(
            "3. Include a strong closing statement with your contact information"),
      ],
    );
  }

  Widget _buildOtherDetailsBulletPoints(String bulletPoints) {
    return AppText(
      text: bulletPoints,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
          ? 20
          : MediaQuery.of(context).size.width <= kScreenWidthXxl
              ? MediaQuery.of(context).size.width / 70
              : 20,
    );
  }

  Widget _buildBlogProfile() {
    return Padding(
      padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 32
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.76
                  : 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Divider(color: AppColors.dividercolor),
        buildSizedBoxH(20),
        Row(
          crossAxisAlignment:
              MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: SizedBox(
                height: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 90
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 7.32
                        : 191,
                width: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 90
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 7.32
                        : 191,
                child: Image.asset('${AppImages.pngImage}img_blog_profile.png',
                    fit: BoxFit.cover),
              ),
            ),
            buildSizedBoxW(22),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Emily Johnson",
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontsize: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 20
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 70
                            : 20,
                  ),
                  AppText(
                      text: "Career Coach and Content Strategist",
                      color: AppColors.text_color_black,
                      fontWeight: FontWeight.w500,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 20
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 70
                              : 20),
                  buildSizedBoxH(12),
                  AppText(
                      text:
                          "Helping job seekers navigate the modern job market with personalized advice and actionable insights.",
                      color: AppColors.text_color_black,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 18
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 77.7
                              : 18),
                  buildSizedBoxH(30),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (!await launchUrl(DataValues.instagramURL)) {
                            throw 'Could not launch ${DataValues.instagramURL}';
                          }
                        },
                        child:
                            SvgPicture.asset('${AppImages.svgImage}insta.svg'),
                      ),
                      buildSizedBoxW(20),
                      GestureDetector(
                        onTap: () async {
                          if (!await launchUrl(DataValues.facebookURL)) {
                            throw 'Could not launch ${DataValues.facebookURL}';
                          }
                        },
                        child: SvgPicture.asset('${AppImages.svgImage}fb.svg',
                            height: 25),
                      ),
                      buildSizedBoxW(20),
                      GestureDetector(
                        onTap: () async {
                          if (!await launchUrl(DataValues.twitterURL)) {
                            throw 'Could not launch ${DataValues.twitterURL}';
                          }
                        },
                        child: SvgPicture.asset(
                            '${AppImages.svgImage}twiter.svg',
                            height: 27),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        buildSizedBoxH(20),
        Divider(color: AppColors.dividercolor),
      ]),
    );
  }

  Widget footer() {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
              text: 'example@gmail.com',
              color: AppColors.white_color,
              fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 38
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 36.8
                      : 38,
              textCenter: true),
          buildSizedBoxH(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(DataValues.linkedinURL)) {
                    throw 'Could not launch ${DataValues.linkedinURL}';
                  }
                },
                child: SvgPicture.asset('${AppImages.svgImage}linkedin.svg',
                    height: MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? 55
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : 80),
              ),
              buildSizedBoxW(16),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(DataValues.pinterestURL)) {
                    throw 'Could not launch ${DataValues.pinterestURL}';
                  }
                },
                child: SvgPicture.asset('${AppImages.svgImage}pinterest.svg',
                    height: MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? 55
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : 80),
              ),
              buildSizedBoxW(16),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(DataValues.githubURL)) {
                    throw 'Could not launch ${DataValues.githubURL}';
                  }
                },
                child: SvgPicture.asset('${AppImages.svgImage}git.svg',
                    height: MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? 55
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : 80),
              ),
              buildSizedBoxW(16),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(DataValues.twitterURL)) {
                    throw 'Could not launch ${DataValues.twitterURL}';
                  }
                },
                child: SvgPicture.asset('${AppImages.svgImage}twitter.svg',
                    height: MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? 55
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : 80),
              ),
              buildSizedBoxW(16),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(DataValues.facebookURL)) {
                    throw 'Could not launch ${DataValues.facebookURL}';
                  }
                },
                child: SvgPicture.asset('${AppImages.svgImage}facebook.svg',
                    height: MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? 55
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 17.5
                            : 80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
