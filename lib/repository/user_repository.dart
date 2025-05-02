// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_resume_creator/models/user.dart';
import 'package:quick_resume_creator/service/firebase/firebase_authentication_service.dart';
import 'package:quick_resume_creator/utils/Error_handler/error_handler.dart';

class UserRepository {
  final authService = AuthenicationService.instance;
  final usersCollection = FirebaseFirestore.instance.collection("users");

  ValueNotifier<UserData?> currentUserNotifier = ValueNotifier<UserData?>(null);

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _userStreamSubscriptions;

  StreamSubscription? _authStreamSubscription;

  String? get currentUserUID => authService.auth.currentUser?.uid;

  set setCurrentUser(UserData? user) {
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  UserRepository() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = null;

    _authStreamSubscription = authService.authStates().listen((firebaseUser) {
      if (firebaseUser != null) {
        final String uid = firebaseUser.uid;
        getCurrentUser(uid);
        log("CURRENT USER -> $uid");
      } else {
        log("NO CURRENT USER");
      }
    });
  }

  Future<Either<ErrorHandler, UserData>> getCurrentUser(
    String uid,
  ) async {
    try {
      final userSnapshot = await usersCollection.doc(uid).get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final UserData user = UserData.fromMap(data);

        setCurrentUser = user;

        listenToCurrentUser(user.uid);

        return Right(user);
      } else {
        return const Left(ErrorHandler(message: "User does not exist"));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, UserData>> login(
      String email, String password) async {
    try {
      final logIn = await authService.logIn(email, password);
      if (logIn.isRight) {
        final firebaseUser = logIn.right;
        final getUser = await getCurrentUser(
          firebaseUser.uid,
        );
        if (getUser.isRight) {
          return Right(getUser.right);
        }

        return Left(getUser.left);
      } else {
        return Left(ErrorHandler(message: logIn.left.message.toString()));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, UserData>> registerUser(
      UserData user, String password) async {
    try {
      final firebaseUser = await authService.signUp(user.email, password);

      if (firebaseUser != null) {
        final newUser = user.copyWith(uid: firebaseUser.uid);
        await usersCollection.doc(firebaseUser.uid).set(newUser.toMap());
        await getCurrentUser(firebaseUser.uid);
        return Right(user);
      }

      return const Left(ErrorHandler(message: "Could'nt register user"));
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Stream<UserData?> listenToCurrentUser(String uid) async* {
    try {
      _userStreamSubscriptions?.cancel();
      _userStreamSubscriptions = null;

      final snapshots = usersCollection.doc(uid).snapshots();

      _userStreamSubscriptions = snapshots.listen((document) {
        if (document.exists) {
          final data = document.data() as Map<String, dynamic>;
          final user = UserData.fromMap(data);
          setCurrentUser = user;
        }
      });
    } catch (e) {
      log(e.toString());
    }

    yield currentUserNotifier.value;
  }

  Future<void> logout() async {
    setCurrentUser = null;
    await authService.logout();
  }

  Future<void> deleteAccount(context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await deleteCurrentUserInvoiceDataCollection();
      await deleteUserDocument(_auth.currentUser?.uid ?? '');
      await _auth.currentUser?.delete();
    } catch (e) {
      log("Error during Delete Account: $e");
    }
  }
}

Future<void> deleteUserDocument(String userId) async {
  try {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await usersRef.where('uid', isEqualTo: userId).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Delete the user document
      await querySnapshot.docs.first.reference.delete();
      log('User data deleted successfully.');
    } else {
      log('User data not found.');
    }
  } catch (e) {
    log('Error deleting user data: $e');
  }
}

Future<void> deleteCurrentUserInvoiceDataCollection() async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      CollectionReference invoiceDataRef = FirebaseFirestore.instance
          .collection('resume_data')
          .doc(currentUser.uid)
          .collection('user_resume');

      QuerySnapshot querySnapshot = await invoiceDataRef.get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      log('User Resume Data collection deleted successfully for the current user.');
    } else {
      log('No user is currently signed in.');
    }
  } catch (e) {
    log('Error deleting current user Resume Data collection: $e');
  }
}
