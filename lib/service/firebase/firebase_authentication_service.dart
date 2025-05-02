import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_resume_creator/utils/Error_handler/error_handler.dart';

class AuthenicationService {
  AuthenicationService._();

  static AuthenicationService? _instance;

  static AuthenicationService get instance {
    _instance ??= AuthenicationService._();
    return _instance!;
  }

  final auth = FirebaseAuth.instance;

  Future<bool> isEmailInUse(String email) async {
    if (!email.contains("@") || email.split(".").length < 2) {
      log("Invalid Email");
      return false;
    }

    try {
      List<String> users = await auth.fetchSignInMethodsForEmail(email.trim());
      if (users.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Either<ErrorHandler, User>> logIn(
      String email, String password) async {
    try {
      final emailInUse = await isEmailInUse(email);
      if (emailInUse) {
        return const Left(ErrorHandler(
            message: "This user does not exist or email badly formatted"));
      }

      final UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        return Right(authResult.user!);
      }

      return const Left(ErrorHandler(message: "Unable to login user"));
    } on FirebaseAuthException catch (error) {
      return Left(ErrorHandler(message: error.message.toString()));
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential authResult = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null) {
        return authResult.user;
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<User?> authStates() {
    return auth.authStateChanges();
  }

  User? currentuser = FirebaseAuth.instance.currentUser;

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log("Password reset email sent successfully");
        }
      });
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
