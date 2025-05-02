import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/repository/user_repository.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'package:quick_resume_creator/service/firebase/firebase_authentication_service.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:quick_resume_creator/widgets/custom_indicator/custom_app_indicator.dart';
import 'package:toastification/toastification.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final ScrollController scrollController;
  const CustomAppBar(
      {super.key, required this.scrollController, required this.selectedIndex});

  @override
  State<CustomAppBar> createState() => _AboutScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _AboutScreenState extends State<CustomAppBar> {
  User? currentuser;

  int selectedIndex = 1;
  bool isHover = false;
  bool isHover1 = false;
  bool isHover2 = false;
  bool isHover3 = false;
  bool isHover4 = false;
  bool isHover5 = false;
  bool isHover6 = false;

  @override
  void initState() {
    AuthenticationService().authStates();
    selectedIndex = widget.selectedIndex;
    super.initState();

    userRefresh();

    widget.scrollController.addListener(() {
      setState(() {
        if (widget.scrollController.offset >= 300) {
          showBackToTopButton = true;
        } else {
          showBackToTopButton = false;
        }
      });
    });
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
    final size = MediaQuery.of(context).size;
    return PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width <= kScreenWidthSm
                  ? kDefaultPadding
                  : kDefaultPadding * 2,
              vertical: kDefaultPadding / 1.1),
          decoration: BoxDecoration(
            color: AppColors.white_color,
            boxShadow: showBackToTopButton
                ? [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: AppColors.text_color_black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (size.width < kScreenWidthSm)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.menu_rounded)),
                        buildSizedBoxW(kDefaultPadding),
                      ],
                    ),
                  Image.asset(
                    "${AppImages.pngImage}img_logo.png",
                    height: 38,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (MediaQuery.of(context).size.width > kScreenWidthMd)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go(RouteUri.initial);
                            Future.delayed(
                              const Duration(milliseconds: 600),
                              () {
                                Scrollable.ensureVisible(
                                  KeyHolder.homeKey.currentContext!,
                                  duration: const Duration(milliseconds: 500),
                                ).then((value) {
                                  selectedIndex = 1;
                                  setState(() {});
                                });
                              },
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (details) =>
                                setState(() => isHover = true),
                            onExit: (details) =>
                                setState(() => isHover = false),
                            child: AppText(
                              text: "Home",
                              color: isHover
                                  ? AppColors.primaryColor
                                  : selectedIndex == 1
                                      ? AppColors.primaryColor
                                      : AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                              fontsize: 15,
                            ),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? kDefaultPadding * 2.2
                                : kDefaultPadding * 4.5),
                        GestureDetector(
                          onTap: () {
                            selectedIndex = 2;
                            setState(() {});
                            GoRouter.of(context).go(RouteUri.about);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (details) =>
                                setState(() => isHover2 = true),
                            onExit: (details) =>
                                setState(() => isHover2 = false),
                            child: AppText(
                              text: "About",
                              color: isHover2
                                  ? AppColors.primaryColor
                                  : selectedIndex == 2
                                      ? AppColors.primaryColor
                                      : AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                              fontsize: 15,
                            ),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? kDefaultPadding * 2.2
                                : kDefaultPadding * 4.5),
                        GestureDetector(
                          onTap: () {
                            selectedIndex = 3;
                            setState(() {});
                            GoRouter.of(context).go(RouteUri.resumeTempletes);
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (details) =>
                                setState(() => isHover3 = true),
                            onExit: (details) =>
                                setState(() => isHover3 = false),
                            child: AppText(
                              text: "Templates",
                              color: isHover3
                                  ? AppColors.primaryColor
                                  : selectedIndex == 3
                                      ? AppColors.primaryColor
                                      : AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                              fontsize: 15,
                            ),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? kDefaultPadding * 2.2
                                : kDefaultPadding * 4.5),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).go(RouteUri.initial);
                            Future.delayed(
                              const Duration(milliseconds: 600),
                              () {
                                Scrollable.ensureVisible(
                                  KeyHolder.blogkey.currentContext!,
                                  duration: const Duration(milliseconds: 500),
                                ).then((value) {
                                  selectedIndex = 4;
                                  setState(() {});
                                });
                              },
                            );
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (details) =>
                                setState(() => isHover4 = true),
                            onExit: (details) =>
                                setState(() => isHover4 = false),
                            child: AppText(
                              text: "Blog",
                              color: isHover4
                                  ? AppColors.primaryColor
                                  : selectedIndex == 4
                                      ? AppColors.primaryColor
                                      : AppColors.text_color_black,
                              fontWeight: FontWeight.w500,
                              fontsize: 15,
                            ),
                          ),
                        ),
                        buildSizedBoxW(
                            MediaQuery.of(context).size.width <= kScreenWidthLg
                                ? kDefaultPadding * 2.2
                                : kDefaultPadding * 4.5),
                      ],
                    ),
                  loginButton(size),
                ],
              ),
            ],
          ),
        ));
  }

  Widget loginButton(Size size) {
    if (currentuser != null) {
      return Row(
        children: [
          _buildprofileWithpopup(context, currentuser!),
        ],
      );
    } else {
      return _buildLoginButton();
    }
  }

  Widget _buildLoginButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => GoRouter.of(context).go(RouteUri.login),
        child: Container(
          height: 41,
          width: 125,
          decoration: BoxDecoration(
            color: AppColors.lightorengecolor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: AppColors.primaryColor),
          ),
          child: Center(
              child: AppText(
            text: "Log In",
            color: AppColors.primaryColor,
            fontsize: 15,
          )),
        ),
      ),
    );
  }

  Widget _buildprofileWithpopup(BuildContext context, User currentuser) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentuser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CupertinoCustomActivityIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return Theme(
            data: ThemeData(hoverColor: Colors.transparent),
            child: PopupMenuButton(
              color: AppColors.white_color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              tooltip: '',
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 'Option 1',
                    onTap: () {
                      GoRouter.of(context).go(RouteUri.resumelist);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding - kTextPadding),
                      child: Row(
                        children: [
                          Icon(
                            Icons.receipt_long_rounded,
                            color: AppColors.primaryColor,
                          ),
                          buildSizedBoxW(25),
                          Text(
                            'My Resume',
                            style: GoogleFonts.jost(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'Option 3',
                    onTap: () {
                      setState(() {
                        AuthenicationService.instance.logout();
                        GoRouter.of(context).pushReplacement(RouteUri.login);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding - kTextPadding),
                      child: Row(
                        children: [
                          Image.asset(
                            '${AppImages.ic}ic_logout.png',
                            color: AppColors.primaryColor,
                            height: 20,
                            fit: BoxFit.cover,
                          ),
                          buildSizedBoxW(25),
                          Text(
                            'Logout',
                            style: GoogleFonts.jost(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              offset: const Offset(0, 50),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 3.5),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:
                            Image.asset('${AppImages.pngImage}img_avtars.png')),
                  ),
                  buildSizedBoxW(kTextPadding),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.text_color_black,
                    size: kDefaultPadding,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
          imagePath: "${AppImages.pngImage}img_dailog_heder.png",
          message: "Are you sure you want to delete your account?",
          positiveButtonText: 'Delete',
          negativeButtonText: 'Cancel',
          onpositivePressed: () {
            UserRepository()
                .deleteAccount(context)
                .then((value) => Navigator.pop(context))
                .then((value) {
              GoRouter.of(context).pushReplacementNamed(RouteUri.login);
              toastification.show(
                type: ToastificationType.success,
                showProgressBar: true,
                context: context,
                autoCloseDuration: const Duration(seconds: 5),
                animationBuilder: (context, animation, alignment, child) {
                  return const Align(alignment: Alignment.topRight);
                },
                animationDuration: const Duration(milliseconds: 300),
                title: const Text("User account deleted successfully."),
              );
            });
          },
        );
      },
    );
  }
}
