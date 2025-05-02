import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/screens/about_screen/about_screen.dart';
import 'package:quick_resume_creator/screens/authentication/forget_password_screen/forget_password_screen.dart';
import 'package:quick_resume_creator/screens/authentication/login_screen/login_screen.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_screen.dart';
import 'package:quick_resume_creator/screens/blog_screen/blog_details_screen.dart';
import 'package:quick_resume_creator/screens/blog_screen/blog_screen.dart';
import 'package:quick_resume_creator/screens/cover_letter_screen/cover_letter_screen.dart';
import 'package:quick_resume_creator/screens/create_resume/create_resume.dart';
import 'package:quick_resume_creator/screens/edit_resume/edit_resume.dart';
import 'package:quick_resume_creator/screens/home_screen/home_screen.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_template_list.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview.dart';
import 'package:quick_resume_creator/screens/resume_templetes_screen/resume_templetes_screen.dart';

class RouteUri {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget-Password';
  static const String initial = '/home';
  static const String createResume = '/home/create-resume';
  static const String editResume = '/edit-resume';
  static const String resumelist = '/resume-list';
  static const String resumeTempletes = '/resume-templetes';
  static const String resumepreview = '/resume-preview';
  static const String blog = '/blogs';
  static const String blogDetails = '/blogs-details';
  static const String generatCoverLetter = '/generate-cover-letter';
  static const String about = '/about';
}

const List<String> unrestrictedRoutes = [RouteUri.login, RouteUri.signup];

// const List<String> publicRoutes = [RouteUri.myDashboard, RouteUri.initial];

GoRouter appRouter() {
  bool isstart = false;
  return GoRouter(
    initialLocation: RouteUri.initial,
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const Center(child: Text('SOMETHING WENT WRONG')),
    ),
    routes: [
      GoRoute(
        name: RouteUri.login,
        path: RouteUri.login,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.signup,
        path: RouteUri.signup,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const SignupScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.forgetPassword,
        path: RouteUri.forgetPassword,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ForgetPasswordScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.initial,
        path: RouteUri.initial,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.createResume,
        path: RouteUri.createResume,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CreateResumeScreen(e: state.extra, isstart: isstart),
        ),
      ),
      GoRoute(
        name: RouteUri.editResume,
        path: RouteUri.editResume,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: EditResumeScreen(extra: state.extra, isstart: isstart),
        ),
      ),
      GoRoute(
        name: RouteUri.resumelist,
        path: RouteUri.resumelist,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ResumeTemplateList(),
        ),
      ),
      GoRoute(
        name: RouteUri.resumepreview,
        path: RouteUri.resumepreview,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: ResumeTempletePreview(isstart: isstart, extra: state.extra),
        ),
      ),
      GoRoute(
        name: RouteUri.blog,
        path: RouteUri.blog,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const BlogScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.blogDetails,
        path: RouteUri.blogDetails,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const BuildBlogDetailsScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.resumeTempletes,
        path: RouteUri.resumeTempletes,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const ResumeTempletesScreen(),
        ),
      ),
      GoRoute(
        name: RouteUri.generatCoverLetter,
        path: RouteUri.generatCoverLetter,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const CoverLetterGeneratorPage(),
        ),
      ),
      GoRoute(
        name: RouteUri.about,
        path: RouteUri.about,
        onExit: (context, state) {
          return isstart = true;
        },
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const AboutScreen(),
        ),
      ),
    ],
    // Uncomment and update the redirect logic as needed.
    // redirect: (context, state) {
    //   if (unrestrictedRoutes.contains(state.matchedLocation)) {
    //     return null;
    //   } else if (publicRoutes.contains(state.matchedLocation)) {
    //     if (AuthenicationService.instance.currentuser != null) {
    //       return RouteUri.homescreen;
    //     }
    //   } else {
    //     if (AuthenicationService.instance.currentuser == null) {
    //       return RouteUri.homescreen;
    //     }
    //   }
    //   return null;
    // },
  );
}
