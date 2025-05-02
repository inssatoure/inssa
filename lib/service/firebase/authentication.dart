import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/models/user.dart';
import 'package:quick_resume_creator/prefs/user_prefs.dart';
import 'package:quick_resume_creator/repository/user_repository.dart';
import 'package:quick_resume_creator/routes/app_route.dart';
import 'package:quick_resume_creator/service/firebase/firebase_authentication_service.dart';
import 'package:quick_resume_creator/service/get_it/get_it.dart';
import 'package:quick_resume_creator/utils/current_time.dart';
import 'package:quick_resume_creator/widgets/custom_app_text/app_text.dart';
import 'package:quick_resume_creator/widgets/custom_dailog_box/custom_dailo_box.dart';
import 'package:toastification/toastification.dart';

class AuthenticationService {
  UserData? currentUser;
  final userRepository = locate<UserRepository>();
  bool isLoading = false;

  static final AuthenticationService _instance =
      AuthenticationService._internal();

  factory AuthenticationService() {
    return _instance;
  }

  AuthenticationService._internal();

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Stream<User?> authStates() {
    return FirebaseAuth.instance.authStateChanges();
  }

  void registerUser(
      context, String username, String email, String password) async {
    final user = UserData(
      permisions: const ['user'],
      uid: "",
      email: email,
      phone: "",
      profileImageUrl: "",
      createdAt: timeNow(),
      updatedAt: timeNow(),
      isActive: true,
      dob: 0,
      username: username,
      logos: "",
    );

    setLoading(true);
    final register = await userRepository.registerUser(user, password);
    setLoading(false);

    if (register.isRight) {
      log("Successfully registered a user");
      Router.neglect(context, () => GoRouter.of(context).go(RouteUri.initial));
    } else {
      String message = "${register.left}";

      if (message.contains('Could\'nt register user')) {
        showDialog(
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return CustomDialog(
              imagePath: "${AppImages.pngImage}img_dailog_heder.png",
              message:
                  "The email address is already in use by another account.",
              positiveButtonText: 'Ok',
              onpositivePressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      } else {
        showDialog(
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return CustomDialog(
              imagePath: "${AppImages.pngImage}img_dailog_heder.png",
              message: message,
              positiveButtonText: 'Ok',
              onpositivePressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      }

      log("${register.left} error");
    }
  }

  setLoading(bool value) {
    isLoading = value;
  }

  void login(
      context, String email, String password, VoidCallback onClose) async {
    if (isLoading == false) {
      setLoading(true);
      final login = await userRepository.login(email, password);
      if (login.isRight) {
        Router.neglect(
            context, () => GoRouter.of(context).go(RouteUri.initial));

        userPrefs?.setBool(Prefobj.AUTHENTICATED, true);
        onClose();
      } else {
        showDialog(
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return CustomDialog(
              imagePath: "${AppImages.pngImage}img_dailog_heder.png",
              message: login.left.message,
              positiveButtonText: 'Ok',
              onpositivePressed: () {
                Navigator.pop(context);
              },
            );
          },
        );
      }
      setLoading(false);
    }
  }

  Future<void> resetPassword(context, String email) async {
    Future.delayed(const Duration(seconds: 1), () async {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        QuerySnapshot querySnapshot = await firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          AuthenicationService.instance.resetPassword(email);

          log(email);
          log("${querySnapshot.docs}");

          toastification.show(
            type: ToastificationType.success,
            showProgressBar: true,
            context: context,
            autoCloseDuration: const Duration(seconds: 5),
            animationDuration: const Duration(milliseconds: 300),
            title: const AppText(
                text: "Reset password link shared successfully to your email."),
          );
          GoRouter.of(context).pushReplacement(RouteUri.login);
        } else {
          showDialog(
            context: context,
            useSafeArea: true,
            builder: (BuildContext context) {
              return CustomDialog(
                message: "This email is not Authorized.",
                positiveButtonText: 'Ok',
                onpositivePressed: () {
                  Navigator.pop(context);
                },
              );
            },
          );
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
