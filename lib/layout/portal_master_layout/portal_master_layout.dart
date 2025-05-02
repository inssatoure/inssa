import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'package:quick_resume_creator/service/firebase/firebase_authentication_service.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_appbar/custom_appbar.dart';

class PortalMasterLayout extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final ScrollController scrollController;
  final int? selectedIndex;
  const PortalMasterLayout(
      {super.key,
      required this.body,
      required this.scrollController,
      this.backgroundColor,
      this.appBar,
      this.selectedIndex});

  @override
  State<PortalMasterLayout> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<PortalMasterLayout>
    with SingleTickerProviderStateMixin {
  User? currentuser;

  List _appDrawerList = [];

  double _scrollProgress = 0.0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  int selectedIndex = 1;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex ?? 1;
    AuthenticationService().authStates();
    super.initState();

    userRefresh();

    widget.scrollController.addListener(() {
      _updateScrollProgress();
      setState(() {
        if (widget.scrollController.offset >= 200) {
          showBackToTopButton = true;
        } else {
          showBackToTopButton = false;
        }
      });
    });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
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

  void _scrollToTop() {
    widget.scrollController.animateTo(0,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  void _updateScrollProgress() {
    double maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    double currentScrollPosition = widget.scrollController.position.pixels;
    double newScrollProgress =
        (currentScrollPosition / maxScrollExtent).clamp(0.0, 1.0);

    _animationController.value = _scrollProgress;
    _animation =
        Tween<double>(begin: _scrollProgress, end: newScrollProgress).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    setState(() {
      _scrollProgress = newScrollProgress;
    });

    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    _appDrawerList = [
      {
        'icon': Icons.home_rounded,
        'title': 'Home',
        'onTap': () {
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
        }
      },
      {
        'icon': Icons.info_rounded,
        'title': 'About',
        'onTap': () {
          selectedIndex = 2;
          setState(() {});
          GoRouter.of(context).go(RouteUri.about);
        }
      },
      {
        'icon': Icons.description_rounded,
        'title': 'Templates',
        'onTap': () {
          selectedIndex = 3;
          setState(() {});
          GoRouter.of(context).go(RouteUri.resumeTempletes);
        }
      },
      {
        'icon': Icons.article_rounded,
        'title': 'Blog',
        'onTap': () {
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
        }
      },
      {
        'icon': Icons.my_library_books_rounded,
        'title': 'My Resume',
        'onTap': () {
          GoRouter.of(context).go(RouteUri.resumelist);
        }
      },
    ];

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? AppColors.authBgcolor,
      appBar: CustomAppBar(
        scrollController: widget.scrollController,
        selectedIndex: selectedIndex,
      ),
      drawer: MediaQuery.of(context).size.width < kScreenWidthSm
          ? _buildAppDrawer()
          : null,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: widget.body,
      ),
      floatingActionButton: showBackToTopButton
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 10.0,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      onPressed: _scrollToTop,
                      child: Icon(Icons.arrow_upward,
                          color: AppColors.primaryColor),
                    ),
                  ],
                );
              },
            )
          : null,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateScrollProgress);
    widget.scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAppDrawer() {
    return Drawer(
        width: MediaQuery.of(context).size.width / 1.35,
        backgroundColor: AppColors.authBgcolor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        surfaceTintColor: AppColors.authBgcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "${AppImages.pngImage}img_logo.png",
                    height: 40,
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.dividercolor, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(kDefaultPadding),
                children: List.generate(
                  _appDrawerList.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: kTextPadding),
                      child: ListTile(
                        hoverColor: AppColors.lightorengecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        leading: Icon(_appDrawerList[index]['icon']),
                        title: AppText(text: _appDrawerList[index]['title']),
                        onTap: _appDrawerList[index]['onTap'],
                      ),
                    );
                  },
                ),
              ),
            ),
            Divider(color: AppColors.dividercolor, height: 1),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding * 2),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: currentuser != null
                        ? ListTile(
                            hoverColor: AppColors.lightorengecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: const Icon(Icons.logout_rounded),
                            title: const AppText(text: "Logout"),
                            onTap: () {
                              setState(() {
                                AuthenicationService.instance.logout();
                                GoRouter.of(context)
                                    .pushReplacement(RouteUri.login);
                              });
                            },
                          )
                        : ListTile(
                            hoverColor: AppColors.lightorengecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: const Icon(Icons.login_rounded),
                            title: const AppText(text: "Log In"),
                            onTap: () =>
                                GoRouter.of(context).go(RouteUri.login),
                          ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
