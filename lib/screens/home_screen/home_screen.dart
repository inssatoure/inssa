import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/animations/image_zoom.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_bloc.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_event.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_state.dart';
import 'package:quick_resume_creator/screens/home_screen/widget/blog_card.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'package:quick_resume_creator/service/firebase/firebase_authentication_service.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Map<String, String>> catalogMap = [
  {'image': '${AppImages.catalogimages}resume_template1.png', 'id': '1'},
  {'image': '${AppImages.catalogimages}resume_template2.png', 'id': '2'},
  {'image': '${AppImages.catalogimages}resume_template3.png', 'id': '3'},
  {'image': '${AppImages.catalogimages}resume_template4.png', 'id': '4'},
  {'image': '${AppImages.catalogimages}resume_template5.png', 'id': '5'},
  {'image': '${AppImages.catalogimages}resume_template6.png', 'id': '6'},
  {'image': '${AppImages.catalogimages}resume_template7.png', 'id': '7'},
  {'image': '${AppImages.catalogimages}resume_template8.png', 'id': '8'},
  {'image': '${AppImages.catalogimages}resume_template9.png', 'id': '9'},
  {'image': '${AppImages.catalogimages}resume_template10.png', 'id': '10'},
];

List blogMap = [
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
    'blogTitle': 'How to Email a Resume\nto Get a Job',
    'blogDescription':
        'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
  },
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts2.png',
    'blogTitle': 'How to Write a Letter of Interest for a Job: Samples & Guide',
    'blogDescription':
        'Your dream workplace never advertises job openings? Send them a letter of interest that will help them notice you and make you a VIP candidate for the next open position.'
  },
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts3.png',
    'blogTitle': 'How to Optimize Your LinkedIn Profile to Get Job Offers',
    'blogDescription':
        'Is your LinkedIn page covered in cobwebs? Time to roll up your sleeves. Learn how to optimize a LinkedIn profile and make it so good that recruiters will find it irresistible.'
  },
];
List smBlogMap = [
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts1.png',
    'blogTitle': 'How to Email a Resume to Get a Job',
    'blogDescription':
        'Ready to send your resume to an employer? Before you hit "send" make sure you\'re not sending a blank email. Learn how to send a resume through email with our guide.'
  },
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts2.png',
    'blogTitle': 'How to Write a Letter of Interest for a Job: Samples & Guide',
    'blogDescription':
        'Your dream workplace never advertises job openings? Send them a letter of interest that will help them notice you and make you a VIP candidate for the next open position.'
  },
  {
    'blogImage': '${AppImages.pngImage}img_blog_posts3.png',
    'blogTitle': 'How to Optimize Your LinkedIn Profile to Get Job Offers',
    'blogDescription':
        'Is your LinkedIn page covered in cobwebs? Time to roll up your sleeves. Learn how to optimize a LinkedIn profile and make it so good that recruiters will find it irresistible.'
  },
];
bool showBackToTopButton = false;

class _HomeScreenState extends State<HomeScreen> {
  User? currentuser;

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController newsLatterEmailController =
      TextEditingController();

  int selectedIndex = 1;
  bool isHover = false;
  bool isHover1 = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover4 = false;
  bool isHover5 = false;
  bool isHover6 = false;

  CarouselSliderController carouselController = CarouselSliderController();

  bool _isYourResumeButtonHovered = false;
  bool _isYourBlogViewMoreButton = false;
  bool _isSlider1ButtonHovered = false;
  bool _isSlider2ButtonHovered = false;
  bool _isSubscribeButtonHovered = false;

  double _scale = 1.0;
  double _scale1 = 1.0;
  double _scale2 = 1.0;

  bool showBackToTopButton = false;
  final ScrollController scrollController = ScrollController();

  late List<bool> isHovered;

  void _mouseEnterYourResumeButton(bool hover) {
    setState(() {
      _isYourResumeButtonHovered = hover;
    });
  }

  void _mouseEnterBlogViewMoreButton(bool hover) {
    setState(() {
      _isYourBlogViewMoreButton = hover;
    });
  }

  void _mouseEnterSubscribeButton(bool hover) {
    setState(() {
      _isSubscribeButtonHovered = hover;
    });
  }

  void _mouseEnterSliderButton(Function(bool) setHover, bool hover) {
    setState(() {
      setHover(hover);
    });
  }

  void _mouseEnter1(bool hover) {
    setState(() {
      _scale = hover ? 1.1 : 1.0;
    });
  }

  void _mouseEnter2(bool hover) {
    setState(() {
      _scale1 = hover ? 1.1 : 1.0;
    });
  }

  void _mouseEnter3(bool hover) {
    setState(() {
      _scale2 = hover ? 1.1 : 1.0;
    });
  }

  void _instagram() async {
    const url = 'https://www.instagram.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _facebook() async {
    const url = 'https://www.facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _twitter() async {
    const url = 'https://twitter.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    AuthenticationService().authStates();
    super.initState();

    userRefresh();

    BlocProvider.of<UserBloc>(context).add(UserCheckRequested());

    isHovered = List<bool>.filled(catalogMap.length, false);
  }

  userRefresh() {
    Future.delayed(const Duration(milliseconds: 0), () {
      AuthenicationService.instance.authStates().listen(
        (User? user) {
          currentuser = user;
          setState(() {});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PortalMasterLayout(
        selectedIndex: 1,
        scrollController: scrollController,
        body: Column(
          children: [
            Divider(
                key: KeyHolder.homeKey,
                color: AppColors.dividercolor,
                height: 1),
            _buildMainScreen(),
            _buildJustSimple(),
            _buildCreateYourResume(),
            _buildCheckYourResume(),
            _buildEasyToImplement(),
            _buildCoverLetter(),
            _buildUseyourresumefeature(),
            _buildOurcoverletters(),
            _buildBlogPost(),
            _buildFotter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainScreen() {
    return MediaQuery.of(context).size.width <= kScreenWidthLg
        ? Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1)),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizedBoxH(kDefaultPadding * 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "${AppImages.pngImage}img_banner.png",
                        height:
                            MediaQuery.of(context).size.width < kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.3
                                : MediaQuery.of(context).size.width / 2,
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.jost(
                          fontSize: 48, fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                            text: "Quick ",
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(
                            text: "Resume Builder To Help You Create ",
                            style:
                                TextStyle(color: AppColors.text_color_black)),
                        TextSpan(
                            text: "Professional ",
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(
                            text: "Resume",
                            style:
                                TextStyle(color: AppColors.text_color_black)),
                      ],
                    ),
                  ),
                  buildSizedBoxH(kTextPadding),
                  AppText(
                    text:
                        "Online cover letter creator, you can easily customize your cover letter to fit the job you’re applying for. Our platform allows you to highlight the skills and experiences that are most relevant to the job, which can increase your chances of getting an interview.",
                    fontsize: 18,
                    color: AppColors.dis_textcolor,
                    height: 2.1,
                  ),
                  buildSizedBoxH(kDefaultPadding * 3),
                  _buildYourResumeButton(),
                  buildSizedBoxH(kDefaultPadding * 3),
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("${AppImages.pngImage}img_banner_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 13,
                  bottom: MediaQuery.of(context).size.width / 13,
                  left: MediaQuery.of(context).size.width / 15,
                  right: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 2.46
                                : 667,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.jost(
                                fontSize: MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 35
                                    : 48,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: "Quick ",
                                  style:
                                      TextStyle(color: AppColors.primaryColor)),
                              TextSpan(
                                  text: "Resume Builder To Help You Create ",
                                  style: TextStyle(
                                      color: AppColors.text_color_black)),
                              TextSpan(
                                  text: "Professional ",
                                  style:
                                      TextStyle(color: AppColors.primaryColor)),
                              TextSpan(
                                  text: "Resume",
                                  style: TextStyle(
                                      color: AppColors.text_color_black)),
                            ],
                          ),
                        ),
                      ),
                      buildSizedBoxH(kTextPadding),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 2.72
                                : 613,
                        child: AppText(
                          text:
                              "Online cover letter creator, you can easily customize your cover letter to fit the job you’re applying for. Our platform allows you to highlight the skills and experiences that are most relevant to the job, which can increase your chances of getting an interview.",
                          fontsize: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 77.77
                              : 18,
                          color: AppColors.dis_textcolor,
                          height: 2.1,
                        ),
                      ),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 25
                              : kDefaultPadding * 3.5),
                      _buildYourResumeButton(),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 21.87
                              : kDefaultPadding * 4),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: AnimatedZoomImage(
                      child: Image.asset(
                        "${AppImages.pngImage}img_banner.png",
                        height:
                            MediaQuery.of(context).size.width < kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.3
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 3
                                    : 600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildYourResumeButton() {
    return MouseRegion(
      onEnter: (event) => _mouseEnterYourResumeButton(true),
      onExit: (event) => _mouseEnterYourResumeButton(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (currentuser != null) {
            GoRouter.of(context).go(RouteUri.resumeTempletes);
          } else {
            GoRouter.of(context).go(RouteUri.createResume);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 60
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 23.33
                      : 60,
              vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 10
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 140
                      : 10),
          decoration: BoxDecoration(
            color: _isYourResumeButtonHovered
                ? AppColors.white_color
                : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: AppColors.primaryColor.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MediaQuery.of(context).size.width <= kScreenWidthSm
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              AppText(
                text: "Build Your Resume",
                fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 16
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 87.5
                        : 16,
                fontWeight: FontWeight.w400,
                color: _isYourResumeButtonHovered
                    ? AppColors.primaryColor
                    : AppColors.white_color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJustSimple() {
    return Padding(
      key: KeyHolder.cvKey,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 2,
          horizontal: kDefaultPadding),
      child: Column(
        children: [
          AppText(
            text: "Just Simple Steps For Download Resume",
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 48
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 35
                    : 48,
            fontWeight: FontWeight.w500,
            textCenter: true,
            color: AppColors.text_color_black,
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding
              : MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 4
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 21.8
                      : kDefaultPadding * 4),
          Image.asset(
            "${AppImages.pngImage}img_process.png",
            width: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 1235.48
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 1.3
                    : 1235.48,
          ),
          buildSizedBoxH(kDefaultPadding),
          SizedBox(key: KeyHolder.templateskey),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding
              : MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 2
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 43.75
                      : kDefaultPadding * 2),
        ],
      ),
    );
  }

  Widget _buildCreateYourResume() {
    return Column(
      children: [
        AppText(
          text: "Create Your Resume",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 48
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 35
                  : 48,
          fontWeight: FontWeight.w500,
          textCenter: true,
          color: AppColors.text_color_black,
        ),
        _buildResumeSlider()
      ],
    );
  }

  Widget _buildResumeSlider() {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigatedToResume) {
          GoRouter.of(context).go(
            RouteUri.createResume,
            extra: state.resumeId,
          );
        }
      },
      child: Column(
        children: [
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 3
              : MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 4
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 21.87
                      : kDefaultPadding * 4),
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20),
                child: CarouselSlider(
                    carouselController: carouselController,
                    items: List.generate(
                      catalogMap.length,
                      (index) => MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (event) =>
                            setState(() => isHovered[index] = true),
                        onExit: (event) =>
                            setState(() => isHovered[index] = false),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<UserBloc>(context).state
                                    is Authenticated
                                ? BlocProvider.of<NavigationBloc>(context).add(
                                    NavigateToResume(catalogMap[index]['id']!))
                                : showDialog(
                                    context: context,
                                    useSafeArea: true,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        imagePath:
                                            "${AppImages.pngImage}img_dailog_heder.png",
                                        message:
                                            "Quick Resume Creator requires Login to access.\n Please Login first.",
                                        positiveButtonText: 'Login',
                                        negativeButtonText: 'Cancel',
                                        onpositivePressed: () {
                                          GoRouter.of(context)
                                              .push(RouteUri.login);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(kTextPadding * 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                if (isHovered[index] ||
                                    (kIsWeb
                                        ? false
                                        : MediaQuery.of(context).size.width <=
                                            kScreenWidthSm))
                                  BoxShadow(
                                    offset: Offset.zero,
                                    color:
                                        AppColors.black_color.withOpacity(0.16),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                  ),
                              ],
                            ),
                            child: Image.asset(catalogMap[index]['image']!),
                          ),
                        ),
                      ),
                    ),
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.width <=
                              kScreenWidthSm
                          ? MediaQuery.of(context).size.width / 1.1
                          : MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? MediaQuery.of(context).size.width / 1.5
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthLg
                                  ? MediaQuery.of(context).size.width / 1.9
                                  : MediaQuery.of(context).size.width / 3.8,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      initialPage: 1,
                      viewportFraction: MediaQuery.of(context).size.width <=
                              kScreenWidthSm
                          ? 0.7
                          : MediaQuery.of(context).size.width <= kScreenWidthMd
                              ? 0.5
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthLg
                                  ? 0.4
                                  : MediaQuery.of(context).size.width <=
                                          kScreenWidthXl
                                      ? 0.21
                                      : 0.2,
                      autoPlay: true,
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildResumeSliderButton(
                      "${AppImages.ic}ic_left_arrow.png",
                      _isSlider1ButtonHovered,
                      (hover) => _isSlider1ButtonHovered = hover,
                      () {
                        carouselController.previousPage();
                      },
                    ),
                    _buildResumeSliderButton(
                      "${AppImages.ic}ic_right_arrow.png",
                      _isSlider2ButtonHovered,
                      (hover) => _isSlider2ButtonHovered = hover,
                      () {
                        carouselController.nextPage();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
              ? kDefaultPadding * 3
              : MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 6
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 14.58
                      : kDefaultPadding * 6),
        ],
      ),
    );
  }

  Widget _buildResumeSliderButton(String image, bool variable,
      Function(bool) setHover, void Function()? onTap) {
    return MouseRegion(
      onEnter: (event) => _mouseEnterSliderButton(setHover, true),
      onExit: (event) => _mouseEnterSliderButton(setHover, false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: MediaQuery.of(context).size.width <= kScreenWidthSm
              ? MediaQuery.of(context).size.width / 12
              : MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 18
                  : MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? MediaQuery.of(context).size.width / 21
                      : MediaQuery.of(context).size.width / 33.10,
          width: MediaQuery.of(context).size.width <= kScreenWidthSm
              ? MediaQuery.of(context).size.width / 12
              : MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? MediaQuery.of(context).size.width / 18
                  : MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? MediaQuery.of(context).size.width / 21
                      : MediaQuery.of(context).size.width / 33.10,
          decoration: BoxDecoration(
              color: variable ? AppColors.primaryColor : AppColors.white_color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: AppColors.black_color.withOpacity(0.25),
                  blurRadius: 10,
                  spreadRadius: 0,
                )
              ]),
          child: Center(
            child: Image.asset(
              image,
              color: variable ? AppColors.white_color : AppColors.primaryColor,
              height: MediaQuery.of(context).size.width <= kScreenWidthSm
                  ? MediaQuery.of(context).size.width / 32
                  : MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? MediaQuery.of(context).size.width / 40
                      : MediaQuery.of(context).size.width <= kScreenWidthLg
                          ? MediaQuery.of(context).size.width / 48
                          : MediaQuery.of(context).size.width / 80,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckYourResume() {
    return Column(
      children: [
        MediaQuery.of(context).size.width <= kScreenWidthLg
            ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "${AppImages.pngImage}img_check_your_resume.png",
                            width: MediaQuery.of(context).size.width <=
                                    kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.1
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? MediaQuery.of(context).size.width / 1.40
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width /
                                            1.98
                                        : 704),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.jost(
                            fontSize: MediaQuery.of(context).size.width <=
                                    kScreenWidthLg
                                ? 48
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 35
                                    : 48,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "Check Your Resume For ",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                          TextSpan(
                              text: "Grammatical ",
                              style: TextStyle(color: AppColors.primaryColor)),
                          TextSpan(
                              text: "And Punctuation Errors",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.5),
                    buildSizedBoxH(kDefaultPadding * 1.5),
                    _buildCheckYourResumePoints(
                        "Wording and readability analysis"),
                    buildSizedBoxH(kDefaultPadding * 1.8),
                    _buildCheckYourResumePoints(
                        "Eliminate typos and grammatical errors"),
                    buildSizedBoxH(kDefaultPadding * 1.8),
                    _buildCheckYourResumePoints(
                        "Content suggestions based on your job and experience"),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: kDefaultPadding * 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthLg
                              ? 546
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthXxl
                                  ? MediaQuery.of(context).size.width / 3
                                  : 546,
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.jost(
                                  fontSize: MediaQuery.of(context).size.width <=
                                          kScreenWidthLg
                                      ? 48
                                      : MediaQuery.of(context).size.width <=
                                              kScreenWidthXxl
                                          ? MediaQuery.of(context).size.width /
                                              35
                                          : 48,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: "Check Your Resume For ",
                                    style: TextStyle(
                                        color: AppColors.text_color_black)),
                                TextSpan(
                                    text: "Grammatical ",
                                    style: TextStyle(
                                        color: AppColors.primaryColor)),
                                TextSpan(
                                    text: "And Punctuation Errors",
                                    style: TextStyle(
                                        color: AppColors.text_color_black)),
                              ],
                            ),
                          ),
                        ),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 58.33
                                : kDefaultPadding * 1.5),
                        _buildCheckYourResumePoints(
                            "Wording and readability analysis"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 50
                                : kDefaultPadding * 1.8),
                        _buildCheckYourResumePoints(
                            "Eliminate typos and grammatical errors"),
                        buildSizedBoxH(
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 50
                                : kDefaultPadding * 1.8),
                        _buildCheckYourResumePoints(
                            "Content suggestions based on your job and experience"),
                      ],
                    ),
                    AnimatedZoomImage(
                      child: Image.asset(
                          "${AppImages.pngImage}img_check_your_resume.png",
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 1.98
                              : 704),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildCheckYourResumePoints(String text) {
    return Row(
      children: [
        Image.asset(
          "${AppImages.ic}ic_check.png",
          height: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 41
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 34.14
                  : 41,
        ),
        buildSizedBoxW(kDefaultPadding + kTextPadding),
        MediaQuery.of(context).size.width <= kScreenWidthSm
            ? Expanded(
                child: AppText(
                  text: text,
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 20
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 70
                          : 20,
                  color: AppColors.text_color_black,
                ),
              )
            : AppText(
                text: text,
                fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 20
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 70
                        : 20,
                color: AppColors.text_color_black,
              ),
      ],
    );
  }

  Widget _buildEasyToImplement() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
            ? kDefaultPadding * 4.5
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 6
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 14.58
                    : kDefaultPadding * 6),
        MediaQuery.of(context).size.width <= kScreenWidthLg
            ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "${AppImages.pngImage}img_easy_to_implement.png",
                            width: MediaQuery.of(context).size.width <=
                                    kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.1
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? MediaQuery.of(context).size.width / 1.57
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width /
                                            2.22
                                        : 630),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.jost(
                            fontSize: MediaQuery.of(context).size.width <=
                                    kScreenWidthLg
                                ? 48
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 35
                                    : 48,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "Easy To ",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                          TextSpan(
                              text: "Implement ",
                              style: TextStyle(color: AppColors.primaryColor)),
                          TextSpan(
                              text: "Design",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.6),
                    AppText(
                      text:
                          "Creating beautiful looking, attention-grabbing designs that will help your cover letter stand out. Easily switch between background and color variations depending on the level of formality.",
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 24
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 58.33
                              : 24,
                      color: AppColors.text_color_black,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedZoomImage(
                      child: Image.asset(
                        "${AppImages.pngImage}img_easy_to_implement.png",
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 2.22
                                : 630,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 2.90
                              : 482,
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.jost(
                                  fontSize: MediaQuery.of(context).size.width <=
                                          kScreenWidthLg
                                      ? 48
                                      : MediaQuery.of(context).size.width <=
                                              kScreenWidthXxl
                                          ? MediaQuery.of(context).size.width /
                                              35
                                          : 48,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: "Easy To\n",
                                    style: TextStyle(
                                        color: AppColors.text_color_black)),
                                TextSpan(
                                    text: "Implement ",
                                    style: TextStyle(
                                        color: AppColors.primaryColor)),
                                TextSpan(
                                    text: "Design",
                                    style: TextStyle(
                                        color: AppColors.text_color_black)),
                              ],
                            ),
                          ),
                        ),
                        buildSizedBoxH(kDefaultPadding * 1.6),
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 2.45
                              : 570,
                          child: AppText(
                            text:
                                "Creating beautiful looking, attention-grabbing designs that will help your cover letter stand out. Easily switch between background and color variations depending on the level of formality.",
                            fontsize: MediaQuery.of(context).size.width <=
                                    kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 58.33
                                : 24,
                            color: AppColors.text_color_black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildCoverLetter() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
            ? kDefaultPadding * 4.5
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 6
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 14.58
                    : kDefaultPadding * 6),
        MediaQuery.of(context).size.width <= kScreenWidthLg
            ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${AppImages.pngImage}img_cover_letter.png",
                            width: MediaQuery.of(context).size.width <=
                                    kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.1
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? MediaQuery.of(context).size.width / 1.64
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width /
                                            2.32
                                        : 603),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.jost(
                            fontSize: MediaQuery.of(context).size.width <=
                                    kScreenWidthLg
                                ? 48
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 35
                                    : 48,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "Cover Letter ",
                              style: TextStyle(color: AppColors.primaryColor)),
                          TextSpan(
                              text: "Generator",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.6),
                    AppText(
                      text:
                          "Let us know a bit more about your experience, skills, and greatest accomplishments, and get your cover letter made for you thanks to our industry-leading creative technology.",
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 24
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 58.33
                              : 24,
                      color: AppColors.text_color_black,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.jost(
                                fontSize: MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? 48
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width / 35
                                        : 48,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: "Cover Letter ",
                                  style:
                                      TextStyle(color: AppColors.primaryColor)),
                              TextSpan(
                                  text: "Generator",
                                  style: TextStyle(
                                      color: AppColors.text_color_black)),
                            ],
                          ),
                        ),
                        buildSizedBoxH(kDefaultPadding * 1.6),
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 2.19
                              : 662,
                          child: AppText(
                            text:
                                "Let us know a bit more about your experience, skills, and greatest accomplishments, and get your cover letter made for you thanks to our industry-leading creative technology.",
                            fontsize: MediaQuery.of(context).size.width <=
                                    kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 58.33
                                : 24,
                            color: AppColors.text_color_black,
                          ),
                        ),
                      ],
                    ),
                    AnimatedZoomImage(
                      child: Image.asset(
                        "${AppImages.pngImage}img_cover_letter.png",
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 2.32
                                : 603,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildUseyourresumefeature() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
            ? kDefaultPadding * 4.5
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 6
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 14.58
                    : kDefaultPadding * 6),
        MediaQuery.of(context).size.width <= kScreenWidthLg
            ? Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            "${AppImages.pngImage}img_use_your_resume_feature.png",
                            width: MediaQuery.of(context).size.width <=
                                    kScreenWidthSm
                                ? MediaQuery.of(context).size.width / 1.1
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthLg
                                    ? MediaQuery.of(context).size.width / 1.68
                                    : MediaQuery.of(context).size.width <=
                                            kScreenWidthXxl
                                        ? MediaQuery.of(context).size.width /
                                            2.37
                                        : 589),
                      ],
                    ),
                    buildSizedBoxH(kDefaultPadding * 2),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.jost(
                            fontSize: MediaQuery.of(context).size.width <=
                                    kScreenWidthLg
                                ? 48
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 35
                                    : 48,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "Use your ",
                              style:
                                  TextStyle(color: AppColors.text_color_black)),
                          TextSpan(
                              text: "Resume Feature",
                              style: TextStyle(color: AppColors.primaryColor)),
                        ],
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.6),
                    AppText(
                      text:
                          "All you need to do is to upload your resume to the builder, and we’ll import the necessary information to create the letter. Take advantage of this feature and save even more time.",
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 24
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 58.33
                              : 24,
                      color: AppColors.text_color_black,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: kDefaultPadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedZoomImage(
                      child: Image.asset(
                        "${AppImages.pngImage}img_use_your_resume_feature.png",
                        width:
                            MediaQuery.of(context).size.width <= kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 2.37
                                : 589,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 2.54
                              : 550,
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.jost(
                                  fontSize: MediaQuery.of(context).size.width <=
                                          kScreenWidthLg
                                      ? 48
                                      : MediaQuery.of(context).size.width <=
                                              kScreenWidthXxl
                                          ? MediaQuery.of(context).size.width /
                                              35
                                          : 48,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                    text: "Use your ",
                                    style: TextStyle(
                                        color: AppColors.text_color_black)),
                                TextSpan(
                                    text: "Resume Feature",
                                    style: TextStyle(
                                        color: AppColors.primaryColor)),
                              ],
                            ),
                          ),
                        ),
                        buildSizedBoxH(kDefaultPadding * 1.6),
                        SizedBox(
                          width: MediaQuery.of(context).size.width <=
                                  kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 2.8
                              : 500,
                          child: AppText(
                            text:
                                "All you need to do is to upload your resume to the builder, and we’ll import the necessary information to create the letter. Take advantage of this feature and save even more time.",
                            fontsize: MediaQuery.of(context).size.width <=
                                    kScreenWidthXxl
                                ? MediaQuery.of(context).size.width / 58.33
                                : 24,
                            color: AppColors.text_color_black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget _buildOurcoverletters() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
            ? kDefaultPadding * 4.5
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 8
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 14.58
                    : kDefaultPadding * 8),
        AppText(
          text: "Our Cover Letters Get People Hired At Top Companies:",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 48
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 35
                  : 48,
          fontWeight: FontWeight.w500,
          textCenter: true,
          color: AppColors.text_color_black,
        ),
        buildSizedBoxH(kDefaultPadding * 2),
        MediaQuery.of(context).size.width <= kScreenWidthMd
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                decoration: BoxDecoration(
                  color: AppColors.white_color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      color: AppColors.black_color.withOpacity(0.16),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Finacial Times",
                      style: GoogleFonts.jomolhari(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.5),
                    Text(
                      "Business.com",
                      style: GoogleFonts.josefinSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.5),
                    Text(
                      "Forbes",
                      style: GoogleFonts.libreBodoni(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    buildSizedBoxH(kDefaultPadding * 1.5),
                    Text(
                      "Life Haker",
                      style: GoogleFonts.merienda(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 150
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 14
                            : 150),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 60
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 23
                            : 60,
                    vertical: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? 30
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 46
                            : 30),
                decoration: BoxDecoration(
                  color: AppColors.white_color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      color: AppColors.black_color.withOpacity(0.16),
                      blurRadius: 6,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: kDefaultPadding * 1.5,
                  runSpacing: kDefaultPadding * 1.5,
                  children: [
                    Text(
                      "Finacial Times",
                      style: GoogleFonts.jomolhari(
                        fontSize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 30
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 46.6
                                    : 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Business.com",
                      style: GoogleFonts.josefinSans(
                        fontSize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 30
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 46.6
                                    : 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Forbes",
                      style: GoogleFonts.libreBodoni(
                        fontSize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 30
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 46.6
                                    : 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Life Haker",
                      style: GoogleFonts.merienda(
                        fontSize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 30
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 46.6
                                    : 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }

  Widget _buildBlogPost() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 2
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 43.75
                    : kDefaultPadding * 2),
        SizedBox(key: KeyHolder.blogkey),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 2
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 43.75
                    : kDefaultPadding * 2),
        AppText(
          text: "Blog Posts",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 48
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 35
                  : 48,
          fontWeight: FontWeight.w500,
          textCenter: true,
          color: AppColors.text_color_black,
        ),
        buildSizedBoxH(kDefaultPadding),
        MediaQuery.of(context).size.width <= kScreenWidthMd + 100
            ? Column(
                children: List.generate(
                  smBlogMap.length,
                  (index) => BuildBlogCard(
                    blogImage: smBlogMap[index]['blogImage'],
                    blogTitle: smBlogMap[index]['blogTitle'],
                    blogDescription: smBlogMap[index]['blogDescription'],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width <=
                            kScreenWidthLg
                        ? kDefaultPadding * 3
                        : MediaQuery.of(context).size.width <= kScreenWidthXxl
                            ? MediaQuery.of(context).size.width / 21.87
                            : kDefaultPadding * 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    blogMap.length,
                    (index) => Expanded(
                      child: BuildBlogCard(
                        blogImage: blogMap[index]['blogImage'],
                        blogTitle: blogMap[index]['blogTitle'],
                        blogDescription: blogMap[index]['blogDescription'],
                      ),
                    ),
                  ),
                ),
              ),
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 87
                : kDefaultPadding),
        _buildBlogViewMoreButton()
      ],
    );
  }

  Widget _buildBlogViewMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: MouseRegion(
        onEnter: (event) => _mouseEnterBlogViewMoreButton(true),
        onExit: (event) => _mouseEnterBlogViewMoreButton(false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).go(RouteUri.blog);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 60
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 23.33
                        : 60,
                vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 10
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 140
                        : 10),
            decoration: BoxDecoration(
              color: _isYourBlogViewMoreButton
                  ? AppColors.white_color
                  : AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  color: AppColors.primaryColor.withOpacity(0.25),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MediaQuery.of(context).size.width <= kScreenWidthSm
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              children: [
                AppText(
                  text: "View More",
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 16
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 87.5
                          : 16,
                  fontWeight: FontWeight.w400,
                  color: _isYourBlogViewMoreButton
                      ? AppColors.primaryColor
                      : AppColors.white_color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFotter() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthSm
            ? kDefaultPadding * 5.5
            : MediaQuery.of(context).size.width <= kScreenWidthLg
                ? kDefaultPadding * 7
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 12.5
                    : kDefaultPadding * 7),
        Container(
          width: double.infinity,
          color: AppColors.lightorengecolor,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding + kTextPadding, vertical: 70),
                  child: Wrap(
                    alignment:
                        MediaQuery.of(context).size.width <= kScreenWidthSm
                            ? WrapAlignment.start
                            : WrapAlignment.spaceEvenly,
                    spacing: kDefaultPadding + kTextPadding,
                    runSpacing: kDefaultPadding * 3,
                    children: [
                      _buildLogowithDescription(),
                      _buildJobSeekers(),
                      _buildOurCompany(),
                      _buildContacts(),
                      _buildJoinNewsletter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFotterTitleText(String fotterTitleText) {
    return AppText(
      text: fotterTitleText,
      fontsize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.text_color_black,
    );
  }

  Widget _buildLogowithDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "${AppImages.pngImage}img_logo.png",
          height: 42,
        ),
        buildSizedBoxH(kDefaultPadding * 1.5),
        SizedBox(
          width: 258,
          child: AppText(
            text:
                "A resume listing key facts about your career and your most important skills is the preferred document for most applications.",
            fontsize: 16,
            color: AppColors.gray_color,
          ),
        ),
        buildSizedBoxH(kDefaultPadding * 1.5),
        AppText(
            text: "Copyright@2024",
            fontsize: 16,
            color: AppColors.text_darkgrey_color),
      ],
    );
  }

  Widget _buildJobSeekers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFotterTitleText("Job Seekers"),
        buildSizedBoxH(kDefaultPadding * 2),
        BuildFotterSubtext(
            fotterSubtext: "Create a Resume",
            onTap: () {
              GoRouter.of(context).go(RouteUri.resumeTempletes);
            }),
        buildSizedBoxH(kDefaultPadding),
        BuildFotterSubtext(
          fotterSubtext: "Resume Templates",
          onTap: () {
            GoRouter.of(context).go(RouteUri.resumeTempletes);
          },
        ),
        buildSizedBoxH(kDefaultPadding),
        BuildFotterSubtext(
          fotterSubtext: "Cover Letter Templates",
          onTap: () {
            GoRouter.of(context).go(RouteUri.generatCoverLetter);
          },
        ),
      ],
    );
  }

  Widget _buildOurCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFotterTitleText("Our Company"),
        buildSizedBoxH(kDefaultPadding * 2),
        BuildFotterSubtext(
            fotterSubtext: "About Us",
            onTap: () {
              GoRouter.of(context).go(RouteUri.about);
            }),
        buildSizedBoxH(kDefaultPadding),
        const BuildFotterSubtext(fotterSubtext: "Features"),
        buildSizedBoxH(kDefaultPadding),
        const BuildFotterSubtext(fotterSubtext: "Products"),
        buildSizedBoxH(kDefaultPadding),
        const BuildFotterSubtext(fotterSubtext: "Pricing"),
        buildSizedBoxH(kDefaultPadding),
        BuildFotterSubtext(
          fotterSubtext: "Blog",
          onTap: () {
            GoRouter.of(context).go(RouteUri.blog);
          },
        ),
      ],
    );
  }

  Widget _buildJoinNewsletter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFotterTitleText("Join a Newsletter"),
        buildSizedBoxH(kDefaultPadding * 2),
        AppText(text: "Your Email", fontsize: 16, color: AppColors.gray_color),
        buildSizedBoxH(kTextPadding * 2),
        _buildJoinNewsletterTextfield(),
        buildSizedBoxH(kDefaultPadding * 1.5),
        _buildJoinNewsletterSocialIcons(),
      ],
    );
  }

  Widget _buildJoinNewsletterTextfield() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FormBuilder(
          key: _formKey,
          child: MediaQuery.of(context).size.width <= kScreenWidthSm
              ? Expanded(
                  child: TextFormField(
                    controller: newsLatterEmailController,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white_color,
                      hintText: "Enter Your Email",
                      hintStyle: GoogleFonts.jost(
                          fontSize: 16, color: AppColors.text_grey_color),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Please enter your email"),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                )
              : SizedBox(
                  width: 296,
                  child: TextFormField(
                    controller: newsLatterEmailController,
                    cursorColor: AppColors.primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white_color,
                      hintText: "Enter Your Email",
                      hintStyle: GoogleFonts.jost(
                          fontSize: 16, color: AppColors.text_grey_color),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: "Please enter your email"),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                ),
        ),
        buildSizedBoxW(kDefaultPadding),
        MouseRegion(
          onEnter: (event) => _mouseEnterSubscribeButton(true),
          onExit: (event) => _mouseEnterSubscribeButton(false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _newsLatterDailog();

                newsLatterEmailController.clear();
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 50,
              width: 158,
              decoration: BoxDecoration(
                color: _isSubscribeButtonHovered
                    ? AppColors.white_color
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(kTextPadding * 2),
                boxShadow: [
                  if (_isSubscribeButtonHovered)
                    BoxShadow(
                      offset: const Offset(0, 4),
                      color: AppColors.primaryColor.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                ],
              ),
              child: Center(
                child: AppText(
                  text: "Subscribe",
                  fontsize: 14,
                  color: _isSubscribeButtonHovered
                      ? AppColors.primaryColor
                      : AppColors.white_color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _newsLatterDailog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(kDefaultPadding),
          backgroundColor: AppColors.white_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultFontSize / 2),
          ),
          title: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      icon: Icon(Icons.close, color: AppColors.primaryColor))
                ],
              ),
              buildSizedBoxH(kDefaultPadding),
              Lottie.asset("${AppImages.lottieImage}newsletter_icon.json",
                  height: 100, repeat: false),
              buildSizedBoxH(kDefaultPadding),
              AppText(
                text: "Success!",
                color: AppColors.text_color_black,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: AppText(
              text: MediaQuery.of(context).size.width <= kScreenWidthMd
                  ? "Thank you for subscribing to our newsletter. You'll now receive the latest resume tips and job search strategies directly in your inbox."
                  : "Thank you for subscribing to our newsletter. You'll now receive the latest resume\ntips and job search strategies directly in your inbox.",
              textCenter: true,
              fontsize: 14,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding * 1.5),
          actions: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).pushNamed(RouteUri.resumeTempletes);
                  GoRouter.of(context).pop();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 60, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        color: AppColors.primaryColor.withOpacity(0.25),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize:
                        MediaQuery.of(context).size.width <= kScreenWidthSm
                            ? MainAxisSize.max
                            : MainAxisSize.min,
                    children: [
                      AppText(
                        text: "Back to Resume Creator",
                        fontsize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white_color,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildJoinNewsletterSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _mouseEnter1(true),
          onExit: (_) => _mouseEnter1(false),
          child: GestureDetector(
            onTap: () => _instagram(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..scale(_scale),
              child: Image.asset("${AppImages.ic}ic_instagram.png", height: 40),
            ),
          ),
        ),
        buildSizedBoxW(kDefaultPadding),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _mouseEnter2(true),
          onExit: (_) => _mouseEnter2(false),
          child: GestureDetector(
            onTap: () => _facebook(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..scale(_scale1),
              child: Image.asset("${AppImages.ic}ic_fb.png", height: 40),
            ),
          ),
        ),
        buildSizedBoxW(kDefaultPadding),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => _mouseEnter3(true),
          onExit: (_) => _mouseEnter3(false),
          child: GestureDetector(
            onTap: () => _twitter(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..scale(_scale2),
              child: Image.asset("${AppImages.ic}ic_twitter.png", height: 40),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFotterTitleText("Contacts"),
        buildSizedBoxH(kDefaultPadding * 2),
        _buildIconWithDetails("${AppImages.ic}ic_location.png",
            "8819 Ohio St. South Gate,\nCA 90280", 22),
        buildSizedBoxH(kDefaultPadding),
        _buildIconWithDetails(
            "${AppImages.ic}ic_email.png", "ourstudio@hello.com", 25),
        buildSizedBoxH(kDefaultPadding),
        _buildIconWithDetails(
            "${AppImages.ic}ic_call.png", "+1 386-688-3295", 20),
      ],
    );
  }

  Widget _buildIconWithDetails(
      String iconImage, String details, double height) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 25,
            width: 25,
            child: Center(
              child: Image.asset(iconImage,
                  height: height, color: AppColors.primaryColor),
            )),
        buildSizedBoxW(kDefaultPadding),
        BuildFotterSubtext(fotterSubtext: details),
      ],
    );
  }
}

class BuildFotterSubtext extends StatefulWidget {
  final String fotterSubtext;
  final VoidCallback? onTap;
  const BuildFotterSubtext(
      {super.key, required this.fotterSubtext, this.onTap});

  @override
  State<BuildFotterSubtext> createState() => _BuildFotterSubtextState();
}

class _BuildFotterSubtextState extends State<BuildFotterSubtext> {
  bool _isHovering = false;

  void _mouseEnter(bool hover) {
    setState(() {
      _isHovering = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _mouseEnter(true),
      onExit: (event) => _mouseEnter(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap ?? () {},
        child: AppText(
          text: widget.fotterSubtext,
          fontsize: 16,
          color: _isHovering ? AppColors.black_color : AppColors.gray_color,
        ),
      ),
    );
  }
}
