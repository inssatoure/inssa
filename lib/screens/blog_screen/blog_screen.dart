import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/widget/blog_card.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final ScrollController scrollController = ScrollController();
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  late int _current = 0;

  List blogMap = [
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
      'blogTitle': 'How to Email a Resume\nto Get a Job',
      'blogDescription':
          'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts2.png',
      'blogTitle':
          'How to Write a Letter of Interest for a Job: Samples & Guide',
      'blogDescription':
          'Your dream workplace never advertises job openings? Send them a letter of interest that will help them notice you and make you a VIP candidate for the next open position.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts3.png',
      'blogTitle': 'How to Optimize Your LinkedIn Profile to Get Job Offers',
      'blogDescription':
          'Is your LinkedIn page covered in cobwebs? Time to roll up your sleeves. Learn how to optimize a LinkedIn profile and make it so good that recruiters will find it irresistible.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
      'blogTitle': 'How to Email a Resume\nto Get a Job',
      'blogDescription':
          'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
    },
  ];

  final List buildBlogSliderList = [
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
      'blogTitle': 'How to Email a Resume to Get a Job',
      'blogDescription':
          'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts2.png',
      'blogTitle':
          'How to Write a Letter of Interest for a Job: Samples & Guide',
      'blogDescription':
          'Your dream workplace never advertises job openings? Send them a letter of interest that will help them notice you and make you a VIP candidate for the next open position.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts3.png',
      'blogTitle': 'How to Optimize Your LinkedIn Profile to Get Job Offers',
      'blogDescription':
          'Is your LinkedIn page covered in cobwebs? Time to roll up your sleeves. Learn how to optimize a LinkedIn profile and make it so good that recruiters will find it irresistible.'
    },
    {
      'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
      'blogTitle': 'How to Email a Resume to Get a Job',
      'blogDescription':
          'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 2 : 1);

    return PortalMasterLayout(
      selectedIndex: 4,
      scrollController: scrollController,
      body: Column(
        children: [
          Divider(color: AppColors.dividercolor, height: 1),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 12.4
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 17.5
                  : kDefaultPadding * 5),
          _buildBlogTitle(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 10.33
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 14.58
                  : kDefaultPadding * 6),
          _buildBlogSlider(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 24.8
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 35
                  : kDefaultPadding * 2.5),
          Divider(
              indent: MediaQuery.of(context).size.width / 10.1,
              endIndent: MediaQuery.of(context).size.width / 10.1),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 15.5
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 21.87
                  : kDefaultPadding * 4),
          _buildBlogs(
              summaryCardCrossAxisCount,
              MediaQuery.of(context).size.width <= kScreenWidthMd + 100
                  ? buildBlogSliderList
                  : blogMap),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 15.5
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 21.87
                  : kDefaultPadding * 4),
        ],
      ),
    );
  }

  Widget _buildBlogTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: "Blogs",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 16
              : 48,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }

  Widget _buildBlogSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
            items: List.generate(
              buildBlogSliderList.length,
              (index) => _buildBlogSliderCard(
                  buildBlogSliderList[index]['blogImage'],
                  buildBlogSliderList[index]['blogTitle'],
                  buildBlogSliderList[index]['blogDescription']),
            ),
            options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: MediaQuery.of(context).size.width <= kScreenWidthMd
                    ? MediaQuery.of(context).size.width / 3.1
                    : MediaQuery.of(context).size.width <= kScreenWidthLg
                        ? MediaQuery.of(context).size.width / 3.4
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 4.2
                            : 465,
                autoPlay: true,
                enableInfiniteScroll: true,
                initialPage: 1,
                viewportFraction: 1)),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? MediaQuery.of(context).size.width / 20.66
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 29.16
                : kDefaultPadding * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildBlogSliderList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? MediaQuery.of(context).size.width / 76.3
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 107.69
                        : 13,
                height: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? MediaQuery.of(context).size.width / 76.3
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 107.69
                        : 13,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                decoration: BoxDecoration(
                    color: _current == entry.key
                        ? AppColors.primaryColor
                        : AppColors.dividercolor,
                    borderRadius: BorderRadius.circular(kDefaultPadding)),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildBlogSliderCard(
      String blogImage, String blogTitle, String blogDescription) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 1.1
              : MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? MediaQuery.of(context).size.width / 1.2
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 1.5
                      : 1300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(blogImage),
              ),
              buildSizedBoxW(MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? MediaQuery.of(context).size.width / 20.66
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 29.16
                      : kDefaultPadding * 3),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: blogTitle,
                      color: AppColors.text_color_black,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? MediaQuery.of(context).size.width / 35.42
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 50
                              : 28,
                      fontWeight: FontWeight.w500,
                    ),
                    buildSizedBoxH(MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? MediaQuery.of(context).size.width / 44.28
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 62.5
                            : kDefaultPadding * 1.4),
                    AppText(
                      text: blogDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? MediaQuery.of(context).size.width / 49.6
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 70
                              : 20,
                      color: AppColors.gray_color,
                    ),
                    buildSizedBoxH(MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? MediaQuery.of(context).size.width / 44.28
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 62.5
                            : kDefaultPadding * 1.4),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).go(RouteUri.blogDetails);

                        window.localStorage['BLOGPOSTTITLE'] = blogTitle;
                        window.localStorage['BLOGPOSTIMAGE'] = blogImage;
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
                                  ? MediaQuery.of(context).size.width / 55.1
                                  : MediaQuery.of(context).size.width <=
                                          kScreenWidthXxl
                                      ? MediaQuery.of(context).size.width / 77.7
                                      : 18,
                              color: AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                            ),
                            Icon(Icons.arrow_outward_rounded,
                                color: AppColors.primaryColor,
                                size: MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? MediaQuery.of(context).size.width / 50
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width /
                                            49.6
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
      ],
    );
  }

  Widget _buildBlogs(int summaryCardCrossAxisCount, List buildBlogSliderList) {
    return MediaQuery.of(context).size.width <= kScreenWidthMd
        ? Column(
            children: List.generate(
              buildBlogSliderList.length,
              (index) => BuildBlogCard(
                  blogImage: buildBlogSliderList[index]["blogImage"],
                  blogTitle: buildBlogSliderList[index]["blogTitle"],
                  blogDescription: buildBlogSliderList[index]
                      ["blogDescription"]),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 8.23
                    : 170.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: BuildBlogCard(
                          blogImage: buildBlogSliderList[0]["blogImage"],
                          blogTitle: buildBlogSliderList[0]["blogTitle"],
                          blogDescription: buildBlogSliderList[0]
                              ["blogDescription"]),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 140
                            : 100),
                    Flexible(
                      child: BuildBlogCard(
                          blogImage: buildBlogSliderList[1]["blogImage"],
                          blogTitle: buildBlogSliderList[1]["blogTitle"],
                          blogDescription: buildBlogSliderList[1]
                              ["blogDescription"]),
                    )
                  ],
                ),
                buildSizedBoxH(25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: BuildBlogCard(
                          blogImage: buildBlogSliderList[2]["blogImage"],
                          blogTitle: buildBlogSliderList[2]["blogTitle"],
                          blogDescription: buildBlogSliderList[2]
                              ["blogDescription"]),
                    ),
                    buildSizedBoxW(
                        MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 140
                            : 100),
                    Flexible(
                      child: BuildBlogCard(
                          blogImage: buildBlogSliderList[3]["blogImage"],
                          blogTitle: buildBlogSliderList[3]["blogTitle"],
                          blogDescription: buildBlogSliderList[3]
                              ["blogDescription"]),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
