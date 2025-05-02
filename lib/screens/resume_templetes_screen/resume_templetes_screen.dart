import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/constants/dimens.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/core/key_holder/key_holder.dart';
import 'package:quick_resume_creator/layout/portal_master_layout/portal_master_layout.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_bloc.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_event.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_state.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';

class ResumeTempletesScreen extends StatefulWidget {
  const ResumeTempletesScreen({super.key});

  @override
  State<ResumeTempletesScreen> createState() => _ResumeTempletesScreenState();
}

class _ResumeTempletesScreenState extends State<ResumeTempletesScreen> {
  final ScrollController scrollController = ScrollController();

  late List<bool> isHovered;

  @override
  void initState() {
    AuthenticationService().authStates();
    super.initState();

    isHovered = List<bool>.filled(catalogMap.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final summaryCardCrossAxisCount = (size.width >= kScreenWidthXxl
        ? 5
        : size.width >= kScreenWidthMd
            ? 3
            : 2);

    return PortalMasterLayout(
      selectedIndex: 3,
      scrollController: scrollController,
      body: Column(
        children: [
          Divider(
              key: KeyHolder.resumeKey,
              color: AppColors.dividercolor,
              height: 1),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 24.8
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 35
                  : kDefaultPadding * 2.5),
          _buildTitle(),
          buildSizedBoxH(MediaQuery.of(context).size.width <= kScreenWidthLg
              ? MediaQuery.of(context).size.width / 20.66
              : MediaQuery.of(context).size.width <= kScreenWidthXxl
                  ? MediaQuery.of(context).size.width / 29.16
                  : kDefaultPadding * 3),
          _buildResumeTempletes(summaryCardCrossAxisCount),
          buildSizedBoxH(kDefaultPadding),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: "Resume Templetes",
          fontsize: MediaQuery.of(context).size.width <= kScreenWidthMd
              ? MediaQuery.of(context).size.width / 16
              : 48,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }

  Widget _buildResumeTempletes(int summaryCardCrossAxisCount) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigatedToResume) {
          GoRouter.of(context).go(
            RouteUri.createResume,
            extra: state.resumeId,
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final summaryCardWidth = ((constraints.maxWidth -
                      (kDefaultPadding * (summaryCardCrossAxisCount - 1))) /
                  summaryCardCrossAxisCount -
              kDefaultPadding);
          return Wrap(
            runSpacing: MediaQuery.of(context).size.width <= kScreenWidthSm
                ? 0
                : kDefaultPadding,
            children: List.generate(
              catalogMap.length,
              (index) => MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (event) => setState(() => isHovered[index] = true),
                onExit: (event) => setState(() => isHovered[index] = false),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<UserBloc>(context).state is Authenticated
                        ? BlocProvider.of<NavigationBloc>(context)
                            .add(NavigateToResume(catalogMap[index]['id']!))
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
                                  GoRouter.of(context).push(RouteUri.login);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                  },
                  child: AnimatedContainer(
                    width: summaryCardWidth,
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
                            color: AppColors.black_color.withOpacity(0.16),
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
          );
        },
      ),
    );
  }
}
