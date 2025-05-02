// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? userPrefs;

loadPrefs() async {
  userPrefs = await SharedPreferences.getInstance();
}

SharedPreferences get getPrefs => userPrefs!;

class Prefobj {
  static const String AUTHENTICATED = 'authenticated';
  static const String UNAUTHENTICATED = 'unauthenticated';
  static const String RESUMEID = 'resumeid';

  static const String CUSTOMERFIRSTNAME = 'customerFirstName';
  static const String CUSTOMERLASTNAME = 'customerLastName';
  static const String CUSTOMERPROFILEIMAGE = 'customerProfileImage';
  static const String CUSTOMERPROFESSION = 'customerProfession';
  static const String CUSTOMERLOCATION = 'customerLocation';
  static const String CUSTOMERWEBSITE = 'customerWebsite';
  static const String CUSTOMERPHONENO = 'customerPhoneNo';
  static const String CUSTOMEREMAILID = 'customerEmailID';
  static const String CUSTOMERPROFESSIONALSUMMARY =
      'customerProfessionalSummary';
  static const String CUSTOMERUNIVERSITY = 'customerUniversity';
  static const String CUSTOMERDEGREE = 'customerDegree';
  static const String CUSTOMERSTARTDATE = 'customerStartDate';
  static const String CUSTOMERENDDATE = 'customerEndDate';
  static const String CUSTOMERJOBTITLE = 'customerJobTitle';
  static const String CUSTOMERCOMPANYNAME = 'customerCompanyName';
  static const String CUSTOMEREMPLOYMENTSTARTDATE =
      'customerEmploymentStartDate';
  static const String CUSTOMEREMPLOYMENTENDDATE = 'customerEmploymentEndDate';
  static const String CUSTOMEREMPLOYMENTADDRESS = 'customerEmploymentAddress';

  static const String BLOGPOSTTITLE = 'blogPostTitle';
  static const String BLOGPOSTIMAGE = 'blogPostImage';

  static const List<dynamic> CUSTOMEREDUCATIONLIST = [];
  static const List<dynamic> CUSTOMEREMPLOYMENTLIST = [];
  static const List<dynamic> CUSTOMERPROFESSIONALSKILLLIST = [];
  static const List<dynamic> CUSTOMERPERSONALSKILLLIST = [];
  static const List<dynamic> CUSTOMERSKILLLIST = [];
}
