import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:quick_resume_creator/config/connection/bloc/connected_bloc.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/repository/quick_resume_creator_repository.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/screens/authentication/forget_password_screen/forget_password_bloc/forget_password_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/login_screen/login_bloc/login_bloc.dart';
import 'package:quick_resume_creator/screens/authentication/signup_screen/signup_bloc/signup_bloc.dart';
import 'package:quick_resume_creator/screens/edit_resume/edit_resume_bloc/edit_resume_bloc.dart';
import 'package:quick_resume_creator/screens/home_screen/user_bloc/user_bloc.dart';
import 'package:quick_resume_creator/screens/resume_template_list/resume_templete_list_bloc/resume_templete_list_bloc.dart';
import 'package:quick_resume_creator/screens/resume_templete_preview/resume_templete_preview_bloc/resume_templete_preview_bloc.dart';
import 'package:quick_resume_creator/service/firebase/authentication.dart';

class QuickResumeCreator extends StatefulWidget {
  const QuickResumeCreator({super.key});

  @override
  State<QuickResumeCreator> createState() => _QuickResumeCreatorState();
}

class _QuickResumeCreatorState extends State<QuickResumeCreator> {
  @override
  Widget build(BuildContext context) {
    GoRouter appRouterInstance = appRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectedBloc>(
          create: (context) => ConnectedBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(() {
            setState(() {});
          }, authenticationService: AuthenticationService()),
        ),
        BlocProvider<SignupBloc>(
          create: (context) =>
              SignupBloc(authenticationService: AuthenticationService()),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => ForgetPasswordBloc(
              authenticationService: AuthenticationService()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<ResumeTempleteListBloc>(
          create: (context) => ResumeTempleteListBloc(
              FirebaseAuth.instance, FirebaseFirestore.instance),
        ),
        BlocProvider<ResumeTemplatePreviewBloc>(
          create: (context) => ResumeTemplatePreviewBloc(),
        ),
        BlocProvider<EditResumeBloc>(
          create: (context) =>
              EditResumeBloc(quickResumeRepository: QuickResumeRepository()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        title: 'Quick Resume Creator',
        routeInformationProvider: appRouterInstance.routeInformationProvider,
        routeInformationParser: appRouterInstance.routeInformationParser,
        routerDelegate: appRouterInstance.routerDelegate,
        localizationsDelegates: const [
          MonthYearPickerLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
      ),
    );
  }
}
