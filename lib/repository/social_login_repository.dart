// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:quick_resume_creator/utils/current_time.dart';
// import 'package:toastification/toastification.dart';

// bool showpogressbar = true;
// dynamic buildAnimation;

// class SocialAuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Future<bool?> signInWithGoogle(BuildContext context) async {
//   // bool result = false;
//   //   try {
//   //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   //     final GoogleSignInAuthentication googleAuth =
//   //         await googleUser!.authentication;
//   //     final AuthCredential credential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );

//   //     UserCredential userCredential =
//   //         await _auth.signInWithCredential(credential);

//   //     User? user = userCredential.user;

//   // if (user != null) {
//   //   if (userCredential.additionalUserInfo!.isNewUser) {
//   //     await _firestore.collection('users').doc(user.uid).set({
//   //       "permisions": const ['user'],
//   //       "login_type": "Google",
//   //       "uid": user.uid,
//   //       "email": user.email,
//   //       "phone": "",
//   //       "profileImageUrl": "",
//   //       "createdAt": timeNow(),
//   //       "updatedAt": timeNow(),
//   //       "isActive": true,
//   //       "dob": 0,
//   //       "firstname": user.displayName!.split(' ')[0],
//   //       "lastname": user.displayName!.split(' ').length > 1
//   //           ? user.displayName!.split(' ').sublist(1).join(' ')
//   //           : '',
//   //       "logos": "",
//   //     });
//   //   }
//   //   result = true;
//   // }
//   //     return result;
//   //   } catch (e) {
//   // log("Google Sign-In Error: $e");
//   // toastification.show(
//   //   type: ToastificationType.error,
//   //   showProgressBar: showpogressbar,
//   //   context: context,
//   //   autoCloseDuration: const Duration(seconds: 5),
//   //   animationBuilder: buildAnimation,
//   //   animationDuration: const Duration(milliseconds: 300),
//   //   title: e.toString() == "popup_closed"
//   //       ? const Text("Oops! Something went wrong")
//   //       : Text(e.toString()),
//   // );
//   //     return null;
//   //   }
//   // }
//   Future<bool?> signInWithGoogle(context) async {
//     User? user;
//     FirebaseAuth auth = FirebaseAuth.instance;
//     GoogleAuthProvider authProvider = GoogleAuthProvider();
//     bool result = false;
//     try {
//       final UserCredential userCredential =
//           await auth.signInWithPopup(authProvider);
//       user = userCredential.user;
//       if (user != null) {
//         if (userCredential.additionalUserInfo!.isNewUser) {
//           await _firestore.collection('users').doc(user.uid).set({
//             "permisions": const ['user'],
//             "login_type": "Google",
//             "uid": user.uid,
//             "email": user.email,
//             "phone": "",
//             "profileImageUrl": "",
//             "createdAt": timeNow(),
//             "updatedAt": timeNow(),
//             "isActive": true,
//             "dob": 0,
//             "firstname": user.displayName!.split(' ')[0],
//             "lastname": user.displayName!.split(' ').length > 1
//                 ? user.displayName!.split(' ').sublist(1).join(' ')
//                 : '',
//             "logos": "",
//           });
//         }
//         result = true;
//       }
//       return result;
//     } catch (e) {
//       log("Google Sign-In Error: $e");
//       toastification.show(
//         type: ToastificationType.error,
//         showProgressBar: showpogressbar,
//         context: context,
//         autoCloseDuration: const Duration(seconds: 5),
//         animationBuilder: buildAnimation,
//         animationDuration: const Duration(milliseconds: 300),
//         title: e.toString() == "popup_closed"
//             ? const Text("Oops! Something went wrong")
//             : Text(e.toString()),
//       );
//     }
//     return null;
//   }

//   Future<bool?> signInWithFacebook(BuildContext context) async {
//     bool result = false;
//     try {
//       final LoginResult loginResult = await FacebookAuth.instance
//           .login(loginBehavior: LoginBehavior.webOnly);

//       if (loginResult.status == LoginStatus.success) {
//         final AccessToken accessToken = loginResult.accessToken!;
//         final AuthCredential credential = FacebookAuthProvider.credential(
//           accessToken.tokenString,
//         );

//         UserCredential userCredential =
//             await _auth.signInWithCredential(credential);

//         User? user = userCredential.user;

//         if (user != null) {
//           if (userCredential.additionalUserInfo!.isNewUser) {
//             await _firestore.collection('users').doc(user.uid).set({
//               "permisions": const ['user'],
//               "login_type": "Facebook",
//               "uid": user.uid,
//               "email": user.email,
//               "phone": "",
//               "profileImageUrl": "",
//               "createdAt": timeNow(),
//               "updatedAt": timeNow(),
//               "isActive": true,
//               "dob": 0,
//               "firstname": user.displayName!.split(' ')[0],
//               "lastname": user.displayName!.split(' ').length > 1
//                   ? user.displayName!.split(' ').sublist(1).join(' ')
//                   : '',
//               "logos": "",
//             });
//           }
//           result = true;
//         }
//         return result;
//       }
//     } catch (e) {
//       log("Facebook Sign-In Error: $e");
//       toastification.show(
//         type: ToastificationType.error,
//         showProgressBar: showpogressbar,
//         context: context,
//         autoCloseDuration: const Duration(seconds: 5),
//         animationBuilder: buildAnimation,
//         animationDuration: const Duration(milliseconds: 300),
//         title: Text(e.toString()),
//       );
//       return result;
//     }
//     return result;
//   }

//   Future<void> signOut() async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     try {
//       await _auth.signOut();
//       await googleSignIn.signOut();
//       await FacebookAuth.instance.logOut();

//       // PrefObj.preferences?.clear();
//       // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
//     } catch (e) {
//       // Logger.lOG("Error during logout: $e");
//     }
//   }

//   Future<void> deleteAccount(context) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     try {
//       await deleteCurrentUserInvoiceDataCollection();
//       await deleteUserDocument(_auth.currentUser?.uid ?? '');
//       await _auth.currentUser?.delete();
//     } catch (e) {
//       log("Error during Delete Account: $e");
//     }
//   }
// }

// Future<void> deleteUserDocument(String userId) async {
//   try {
//     CollectionReference usersRef =
//         FirebaseFirestore.instance.collection('users');

//     QuerySnapshot querySnapshot =
//         await usersRef.where('uid', isEqualTo: userId).limit(1).get();

//     if (querySnapshot.docs.isNotEmpty) {
//       // Delete the user document
//       await querySnapshot.docs.first.reference.delete();
//       log('User data deleted successfully.');
//     } else {
//       log('User data not found.');
//     }
//   } catch (e) {
//     log('Error deleting user data: $e');
//   }
// }

// Future<void> deleteCurrentUserInvoiceDataCollection() async {
//   try {
//     User? currentUser = FirebaseAuth.instance.currentUser;

//     if (currentUser != null) {
//       CollectionReference invoiceDataRef = FirebaseFirestore.instance
//           .collection('quick_resume_data')
//           .doc(currentUser.uid)
//           .collection('user_quickresume');

//       QuerySnapshot querySnapshot = await invoiceDataRef.get();

//       for (var doc in querySnapshot.docs) {
//         await doc.reference.delete();
//       }

//       log('User quickresume Data collection deleted successfully for the current user.');
//     } else {
//       log('No user is currently signed in.');
//     }
//   } catch (e) {
//     log('Error deleting current user quickresume Data collection: $e');
//   }
// }
