import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_resume_creator/core/colors/app_colors.dart';
import 'package:quick_resume_creator/core/image/app_image.dart';
import 'package:quick_resume_creator/widgets/custom_image_view/custom_image_view.dart';

class CustomLogoViewer extends StatefulWidget {
  const CustomLogoViewer({super.key});

  @override
  State<CustomLogoViewer> createState() => _CustomLogoViewerState();
}

class _CustomLogoViewerState extends State<CustomLogoViewer> {
  User? currentUser;
  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2.5,
                  )),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Text('No data available');
          } else {
            String? imageUrl = snapshot.data!.get('logos');

            if (imageUrl != null && imageUrl.isNotEmpty) {
              return CustomImageView(
                url: imageUrl,
                height: MediaQuery.of(context).size.height / 30,
              );
            } else {
              return CustomImageView(
                svgPath: '${AppImages.svgImage}svg_app_logo.svg',
                height: MediaQuery.of(context).size.height / 30,
              );
            }
          }
        });
  }
}
