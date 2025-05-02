import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quick_resume_creator/core/animations/image_zoom.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

List meetOutTeamList = [
  {
    'image': "${AppImages.pngImage}img_team1.jpg",
    'name': "John Doe",
    'profession': "Design Expert",
    'description':
        "John is our resident design guru, with a keen eye for aesthetics and a passion for creating beautiful user experiences."
  },
  {
    'image': "${AppImages.pngImage}img_team2.jpg",
    'name': "Jane Smith",
    'profession': "Tech Guru",
    'description':
        "Jane is our resident tech expert, with a deep understanding of the latest technologies and a passion for building cutting-edge solutions."
  },
  {
    'image': "${AppImages.pngImage}img_team3.jpg",
    'name': "Michael Johnson",
    'profession': "Marketing Wizard",
    'description':
        "Michael is our marketing mastermind, with a knack for crafting compelling campaigns that drive results."
  },
  {
    'image': "${AppImages.pngImage}img_team4.jpg",
    'name': "Sarah Lee",
    'profession': "Project Manager",
    'description':
        "Sarah is our project management extraordinaire, ensuring that every project is delivered on time and to the highest standards."
  },
];

List ourStoryList = [
  {
    'icon': Icons.lightbulb_outline_rounded,
    'title': "Milestone 1: Idea Conception",
    'description':
        "In 2019, we came up with the idea to create a user-friendly resume maker app."
  },
  {
    'icon': Icons.code_rounded,
    'title': "Milestone 2: Development Starts",
    'description':
        "In 2020, we began developing the first version of our app, focusing on core features."
  },
  {
    'icon': Icons.rocket_launch_outlined,
    'title': "Milestone 3: Beta Launch",
    'description':
        "In early 2021, we launched a beta version and received valuable feedback from users."
  },
  {
    'icon': Icons.star_border_rounded,
    'title': "Milestone 4: Official Release",
    'description':
        "In late 2021, we officially released the app with enhanced features and a polished UI."
  },
  {
    'icon': Icons.people_outline,
    'title': "Milestone 5: Community Growth",
    'description':
        "In 2022, we expanded our team and continued to improve the app based on user feedback."
  },
];

List elevateYourResumeList = [
  {
    'icon': Icons.mode_edit_outlined,
    'title': "Easy Resume Editing",
    'description':
        "Effortlessly customize your resume with our intuitive editor. Drag and drop sections, change fonts, and more."
  },
  {
    'icon': Icons.widgets_outlined,
    'title': "Professional Templates",
    'description':
        "Choose from our library of modern, ATS-friendly resume templates to make a great first impression."
  },
  {
    'icon': Icons.work_outline_rounded,
    'title': "Professional Templates",
    'description':
        "Choose from our library of modern, ATS-friendly resume templates to make a great first impression."
  },
  {
    'icon': Icons.check_rounded,
    'title': "Comprehensive Feedback",
    'description':
        "Get personalized feedback on your resume from our team of experts to ensure it stands out."
  },
  {
    'icon': Icons.file_download_outlined,
    'title': "Easy Downloading",
    'description':
        "Download your resume in multiple formats, including PDF, Word, and more, to share with potential employers."
  },
  {
    'icon': Icons.cloud_queue_rounded,
    'title': "Secure Cloud Storage",
    'description':
        "Store your resume securely in the cloud and access it from any device, ensuring your information is always at hand."
  },
];
List whatOurUsersList = [
  {
    'rating': 5,
    'title': "Sarah Johnson",
    'description':
        "\"The resume maker was a game-changer for me. It helped me create a professional-looking resume that really showcased my skills and experience. I landed my dream job just a few weeks after using it.\""
  },
  {
    'rating': 4,
    'title': "Alex Smith",
    'description':
        "\"I was struggling to put together a resume that highlighted my skills and experience, but the resume maker made it so easy. The templates and guidance were exactly what I needed to land my new job.\""
  },
  {
    'rating': 3.5,
    'title': "Emily Parker",
    'description':
        "\"I was hesitant to use a resume maker at first, but I'm so glad I did. The resume maker helped me create a polished and professional resume that really stood out to potential employers. I got multiple job offers after using it.\""
  },
];

class _AboutScreenState extends State<AboutScreen> {
  late ScrollController scrollController = ScrollController();

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController newsLatterEmailController =
      TextEditingController();

  double _scale = 1.0;
  double _scale1 = 1.0;
  double _scale2 = 1.0;

  bool _isGetStartedButtonHovered = false;
  bool _isLearnMoreButtonHovered = false;
  bool _isSubscribeButtonHovered = false;

  void _mouseEnterGetStartedButton(bool hover) {
    setState(() {
      _isGetStartedButtonHovered = hover;
    });
  }

  void _mouseEnterLearnMoreButton(bool hover) {
    setState(() {
      _isLearnMoreButtonHovered = hover;
    });
  }

  void _mouseEnterSubscribeButton(bool hover) {
    setState(() {
      _isSubscribeButtonHovered = hover;
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final elevateYourResumeCrossAxisCount = (size.width >= kScreenWidthXxl
        ? 3
        : size.width >= kScreenWidthMd
            ? 2
            : 1);
    return PortalMasterLayout(
      selectedIndex: 2,
      scrollController: scrollController,
      body: Column(
        children: [
          Divider(
              key: KeyHolder.resumeKey,
              color: AppColors.dividercolor,
              height: 1),
          _buildMainScreen(),
          _buildMeetOurTeam(),
          _buildOurStory(),
          _buildelevateYourResume(elevateYourResumeCrossAxisCount),
          _buildWhatOurUsers(),
          _buildReadyToTake(),
          _buildFotter(),
        ],
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
                        "${AppImages.pngImage}img_about.png",
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
                            text: "Empowering ",
                            style:
                                TextStyle(color: AppColors.text_color_black)),
                        TextSpan(
                            text: "Your Career ",
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(
                            text: "Journey ",
                            style:
                                TextStyle(color: AppColors.text_color_black)),
                      ],
                    ),
                  ),
                  buildSizedBoxH(kTextPadding),
                  AppText(
                    text:
                        "Our mission is to simplify the resume creation process and help you land your dream job.",
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
                                  text: "Empowering ",
                                  style: TextStyle(
                                      color: AppColors.text_color_black)),
                              TextSpan(
                                  text: "Your Career\n",
                                  style:
                                      TextStyle(color: AppColors.primaryColor)),
                              TextSpan(
                                  text: "Journey ",
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
                              "Our mission is to simplify the resume creation process\nand help you land your dream job.",
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
                              ? MediaQuery.of(context).size.width / 58.33
                              : kDefaultPadding * 1.5),
                      _buildYourResumeButton(),
                      buildSizedBoxH(
                          MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 21.87
                              : kDefaultPadding * 4),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: kDefaultPadding * 1.5),
                    child: AnimatedZoomImage(
                      child: Image.asset(
                        "${AppImages.pngImage}img_about.png",
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
    return MediaQuery.of(context).size.width <= kScreenWidthSm
        ? Column(
            children: [
              MouseRegion(
                onEnter: (event) => _mouseEnterGetStartedButton(true),
                onExit: (event) => _mouseEnterGetStartedButton(false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(RouteUri.initial);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 60
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 23.33
                                    : 60,
                        vertical:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 10
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 140
                                    : 10),
                    decoration: BoxDecoration(
                      color: _isGetStartedButtonHovered
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
                      mainAxisSize:
                          MediaQuery.of(context).size.width <= kScreenWidthSm
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                      children: [
                        AppText(
                          text: "Get Started",
                          fontsize: MediaQuery.of(context).size.width <=
                                  kScreenWidthLg
                              ? 16
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthXxl
                                  ? MediaQuery.of(context).size.width / 87.5
                                  : 16,
                          fontWeight: FontWeight.w400,
                          color: _isGetStartedButtonHovered
                              ? AppColors.primaryColor
                              : AppColors.white_color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildSizedBoxH(kDefaultPadding),
              MouseRegion(
                onEnter: (event) => _mouseEnterLearnMoreButton(true),
                onExit: (event) => _mouseEnterLearnMoreButton(false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 60
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 23.33
                                    : 60,
                        vertical:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 10
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 140
                                    : 10),
                    decoration: BoxDecoration(
                      color: _isLearnMoreButtonHovered
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
                      mainAxisSize:
                          MediaQuery.of(context).size.width <= kScreenWidthSm
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                      children: [
                        AppText(
                          text: "Learn More",
                          fontsize: MediaQuery.of(context).size.width <=
                                  kScreenWidthLg
                              ? 16
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthXxl
                                  ? MediaQuery.of(context).size.width / 87.5
                                  : 16,
                          fontWeight: FontWeight.w400,
                          color: _isLearnMoreButtonHovered
                              ? AppColors.primaryColor
                              : AppColors.white_color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: [
              MouseRegion(
                onEnter: (event) => _mouseEnterGetStartedButton(true),
                onExit: (event) => _mouseEnterGetStartedButton(false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).go(RouteUri.initial);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 60
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 23.33
                                    : 60,
                        vertical:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 10
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 140
                                    : 10),
                    decoration: BoxDecoration(
                      color: _isGetStartedButtonHovered
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
                      mainAxisSize:
                          MediaQuery.of(context).size.width <= kScreenWidthSm
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                      children: [
                        AppText(
                          text: "Get Started",
                          fontsize: MediaQuery.of(context).size.width <=
                                  kScreenWidthLg
                              ? 16
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthXxl
                                  ? MediaQuery.of(context).size.width / 87.5
                                  : 16,
                          fontWeight: FontWeight.w400,
                          color: _isGetStartedButtonHovered
                              ? AppColors.primaryColor
                              : AppColors.white_color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              buildSizedBoxW(kDefaultPadding),
              MouseRegion(
                onEnter: (event) => _mouseEnterLearnMoreButton(true),
                onExit: (event) => _mouseEnterLearnMoreButton(false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 60
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 23.33
                                    : 60,
                        vertical:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 10
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 140
                                    : 10),
                    decoration: BoxDecoration(
                      color: _isLearnMoreButtonHovered
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
                      mainAxisSize:
                          MediaQuery.of(context).size.width <= kScreenWidthSm
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                      children: [
                        AppText(
                          text: "Learn More",
                          fontsize: MediaQuery.of(context).size.width <=
                                  kScreenWidthLg
                              ? 16
                              : MediaQuery.of(context).size.width <=
                                      kScreenWidthXxl
                                  ? MediaQuery.of(context).size.width / 87.5
                                  : 16,
                          fontWeight: FontWeight.w400,
                          color: _isLearnMoreButtonHovered
                              ? AppColors.primaryColor
                              : AppColors.white_color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  Widget _buildMeetOurTeam() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 3,
          horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppText(
              text: "Meet Our Team",
              textCenter: true,
              fontsize: 48,
              fontWeight: FontWeight.w600),
          buildSizedBoxH(kTextPadding),
          SizedBox(
            width: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 1.75
                    : 800,
            child: AppText(
              text:
                  "Our talented team of experts is dedicated to delivering exceptional results.",
              textCenter: true,
              fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 18
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 77.77
                      : 18,
              color: AppColors.text_color_black,
              height: 1.8,
            ),
          ),
          buildSizedBoxH(kDefaultPadding * 2),
          Wrap(
            children: List.generate(
              meetOutTeamList.length,
              (index) => MeetOutTeamCard(
                  image: meetOutTeamList[index]['image'],
                  name: meetOutTeamList[index]['name'],
                  profession: meetOutTeamList[index]['profession'],
                  description: meetOutTeamList[index]['description']),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOurStory() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding * 2
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 43.75
                : kDefaultPadding * 3,
      ),
      child: Container(
        color: AppColors.primaryColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildSizedBoxH(
                  MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 29.16
                      : kDefaultPadding * 3),
              const AppText(
                  text: "Our Story",
                  textCenter: true,
                  fontsize: 48,
                  fontWeight: FontWeight.w600),
              buildSizedBoxH(kTextPadding),
              SizedBox(
                width: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 1.75
                        : 800,
                child: AppText(
                  text:
                      "The idea for our resume maker app came about when we realized how challenging it was for job seekers to create professional resumes that stood out. We wanted to simplify the process and provide a tool that would help individuals showcase their skills and experience effectively.",
                  textCenter: true,
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 18
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 77.77
                          : 18,
                  color: AppColors.text_color_black,
                  height: 1.8,
                ),
              ),
              buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 2
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 43.75
                      : kDefaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              ourStoryList.length,
                              (index) => _buildOurStoryCard(
                                  ourStoryList[index]['icon'],
                                  ourStoryList[index]['title'],
                                  ourStoryList[index]['description']),
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            ourStoryList.length,
                            (index) => _buildOurStoryCard(
                                ourStoryList[index]['icon'],
                                ourStoryList[index]['title'],
                                ourStoryList[index]['description']),
                          ),
                        ),
                ],
              ),
              buildSizedBoxH(
                  MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 43
                      : kDefaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOurStoryCard(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 2),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 80
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 17.5
                    : 80,
            width: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 80
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 17.5
                    : 80,
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? 7
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 200
                        : 7),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.white_color,
              size: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 30
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 46.66
                      : 30,
            ),
          ),
          buildSizedBoxW(kDefaultPadding * 1.5),
          MediaQuery.of(context).size.width <= kScreenWidthLg
              ? Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: title,
                        fontsize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 20
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 70
                                    : 20,
                        fontWeight: FontWeight.w600,
                      ),
                      AppText(
                        text: description,
                        fontsize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 18
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 77.77
                                    : 18,
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: title,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 20
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 70
                              : 20,
                      fontWeight: FontWeight.w600,
                    ),
                    AppText(
                      text: description,
                      fontsize: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 18
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 77.77
                              : 18,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildelevateYourResume(int elevateYourResumeCrossAxisCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthXxl
              ? MediaQuery.of(context).size.width / 29.16
              : kDefaultPadding * 3),
          const AppText(
              text: "Elevate Your Resume with Our Builder",
              textCenter: true,
              fontsize: 48,
              fontWeight: FontWeight.w600),
          buildSizedBoxH(kTextPadding),
          SizedBox(
            width: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 1.75
                    : 800,
            child: AppText(
              text:
                  "Discover the power of our resume builder and transform your job search.",
              textCenter: true,
              fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 18
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 77.77
                      : 18,
              color: AppColors.text_color_black,
              height: 1.8,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 2),
          SizedBox(
            width: 950,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final summaryCardWidth = ((constraints.maxWidth -
                            (kDefaultPadding *
                                (elevateYourResumeCrossAxisCount - 1))) /
                        elevateYourResumeCrossAxisCount -
                    kDefaultPadding);
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: kDefaultPadding * 1.5,
                  runSpacing: kDefaultPadding * 1.5,
                  children: List.generate(
                    elevateYourResumeList.length,
                    (index) => _buildelevateYourResumeCard(
                        elevateYourResumeList[index]['icon'],
                        elevateYourResumeList[index]['title'],
                        elevateYourResumeList[index]['description'],
                        summaryCardWidth),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildelevateYourResumeCard(IconData icon, String title,
      String description, double summaryCardWidth) {
    return Container(
      width: MediaQuery.of(context).size.width >= kScreenWidthXl
          ? MediaQuery.of(context).size.width <= kScreenWidthLg
              ? 300
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 4.66
                  : 300
          : summaryCardWidth,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(color: AppColors.lightorengecolor, boxShadow: [
        BoxShadow(
          color: AppColors.black_color.withOpacity(0.07),
          blurRadius: 8,
          offset: const Offset(0, 5),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? kDefaultPadding
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 87.5
                        : kDefaultPadding),
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Icon(
              icon,
              color: AppColors.white_color,
              size: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 24
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 58.33
                      : 24,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 87.5
                  : kDefaultPadding),
          AppText(
            text: title,
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 20
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 70
                    : 20,
            fontWeight: FontWeight.w600,
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 87.5
                  : kDefaultPadding),
          AppText(
            text: description,
            fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? 18
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 77.77
                    : 18,
          ),
        ],
      ),
    );
  }

  Widget _buildWhatOurUsers() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 3,
          horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthXxl
              ? MediaQuery.of(context).size.width / 29.16
              : kDefaultPadding * 3),
          const AppText(
              text: "What Our Users Say",
              textCenter: true,
              fontsize: 48,
              fontWeight: FontWeight.w600),
          buildSizedBoxH(kTextPadding),
          SizedBox(
            width: MediaQuery.of(context).size.width <= kScreenWidthLg
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width <= kScreenWidthXxl
                    ? MediaQuery.of(context).size.width / 1.75
                    : 800,
            child: AppText(
              text:
                  "Hear from real people who have used our resume maker to land their dream jobs.",
              textCenter: true,
              fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 18
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 77.77
                      : 18,
              color: AppColors.text_color_black,
              height: 1.8,
            ),
          ),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding * 2
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 43.75
                  : kDefaultPadding * 2),
          Wrap(
            spacing: kDefaultPadding,
            runSpacing: kDefaultPadding,
            children: List.generate(
              whatOurUsersList.length,
              (index) => _buildWhatOurUsersCard(
                rating: whatOurUsersList[index]['rating'],
                name: whatOurUsersList[index]['title'],
                description: whatOurUsersList[index]['description'],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWhatOurUsersCard(
      {required double rating,
      required String name,
      required String description}) {
    return Container(
      height: MediaQuery.of(context).size.width <= kScreenWidthLg
          ? 253
          : MediaQuery.of(context).size.width <= kScreenWidthXxl
              ? MediaQuery.of(context).size.width / 5.5
              : 253,
      width: MediaQuery.of(context).size.width <= kScreenWidthLg
          ? 400
          : MediaQuery.of(context).size.width <= kScreenWidthXxl
              ? MediaQuery.of(context).size.width / 3.5
              : 400,
      padding:
          EdgeInsets.all(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? kDefaultPadding
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 87.5
                  : kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kTextPadding * 2),
        border: Border.all(color: AppColors.black_color.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(
                MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? kDefaultPadding / 1.5
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 130.25
                        : kDefaultPadding / 1.5),
            decoration: BoxDecoration(
                color: AppColors.white_color,
                border:
                    Border.all(color: AppColors.black_color.withOpacity(0.3)),
                shape: BoxShape.circle),
            child: Icon(
              Icons.person_outline_rounded,
              color: AppColors.primaryColor,
              size: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? 24
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 58.33
                      : 24,
            ),
          ),
          buildSizedBoxW(kDefaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                        text: name,
                        textCenter: true,
                        fontsize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 20
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 70
                                    : 20,
                        fontWeight: FontWeight.w600),
                    buildSizedBoxW(kTextPadding),
                    StarRating(
                      rating: rating,
                      allowHalfRating: true,
                      filledIcon: Icons.star_rounded,
                      halfFilledIcon: Icons.star_half_rounded,
                      emptyIcon: Icons.star_outline_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                      onRatingChanged: (rating) {},
                    ),
                  ],
                ),
                buildSizedBoxH(kTextPadding),
                AppText(
                  text: description,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 18
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 77.77
                          : 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReadyToTake() {
    return Column(
      children: [
        buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
            ? kDefaultPadding * 3
            : MediaQuery.of(context).size.width <= kScreenWidthXxl
                ? MediaQuery.of(context).size.width / 29.16
                : kDefaultPadding * 3),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width <= kScreenWidthLg
                  ? kDefaultPadding * 4
                  : MediaQuery.of(context).size.width <= kScreenWidthXxl
                      ? MediaQuery.of(context).size.width / 43.75
                      : kDefaultPadding * 4,
              horizontal: kDefaultPadding),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              AppText(
                  text: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? "Ready to take the next step in your career?"
                      : "Ready to take the next step in\nyour career?",
                  textCenter: true,
                  color: AppColors.white_color,
                  fontsize: 48,
                  fontWeight: FontWeight.w600),
              buildSizedBoxH(kTextPadding),
              SizedBox(
                width: MediaQuery.of(context).size.width <= kScreenWidthLg
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width <= kScreenWidthXxl
                        ? MediaQuery.of(context).size.width / 1.75
                        : 800,
                child: AppText(
                  text: MediaQuery.of(context).size.width <= kScreenWidthMd
                      ? "Create a professional resume in minutes with our easy-to-use resume builder."
                      : "Create a professional resume in minutes with our easy-to-use resume\nbuilder.",
                  textCenter: true,
                  color: AppColors.white_color,
                  fontsize: MediaQuery.of(context).size.width <= kScreenWidthLg
                      ? 18
                      : MediaQuery.of(context).size.width <= kScreenWidthXxl
                          ? MediaQuery.of(context).size.width / 77.77
                          : 18,
                  height: 1.8,
                ),
              ),
              buildSizedBoxH(kDefaultPadding),
              GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 60
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 23.33
                              : 60,
                      vertical: MediaQuery.of(context).size.width <=
                              kScreenWidthLg
                          ? 10
                          : MediaQuery.of(context).size.width <= kScreenWidthXxl
                              ? MediaQuery.of(context).size.width / 140
                              : 10),
                  decoration: BoxDecoration(
                    color: AppColors.white_color,
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
                        text: "Start Building Your Resume",
                        fontsize:
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? 16
                                : MediaQuery.of(context).size.width <=
                                        kScreenWidthXxl
                                    ? MediaQuery.of(context).size.width / 87.5
                                    : 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
            borderRadius: BorderRadius.circular(kDefaultPadding),
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

class MeetOutTeamCard extends StatefulWidget {
  final String image;
  final String name;
  final String profession;
  final String description;
  const MeetOutTeamCard(
      {super.key,
      required this.image,
      required this.name,
      required this.profession,
      required this.description});

  @override
  State<MeetOutTeamCard> createState() => _MeetOutTeamCardState();
}

class _MeetOutTeamCardState extends State<MeetOutTeamCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
        width: MediaQuery.of(context).size.width <= kScreenWidthSm
            ? MediaQuery.of(context).size.width
            : 300,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black_color.withOpacity(isHovered ? 0.3 : 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding / 1.5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.9),
                        AppColors.primaryColor.withOpacity(0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppText(
                          text: widget.name,
                          color: AppColors.white_color,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                      ),
                      buildSizedBoxW(kDefaultPadding),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AppText(
                          text: widget.profession,
                          color: AppColors.white_color,
                          fontsize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width <= kScreenWidthSm
                ? Container(
                    color: AppColors.primaryColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: AppText(
                            text: widget.description,
                            color: AppColors.white_color,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                : Container(
                    height: 130,
                    color: AppColors.primaryColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: AppText(
                            text: widget.description,
                            color: AppColors.white_color,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
