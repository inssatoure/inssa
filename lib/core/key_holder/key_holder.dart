import 'package:flutter/material.dart';

class KeyHolder {
  static final GlobalKey homeKey = GlobalKey();
  static final GlobalKey resumeKey = GlobalKey();
  static final GlobalKey cvKey = GlobalKey();
  static final GlobalKey templateskey = GlobalKey();
  static final GlobalKey blogkey = GlobalKey();
}

class DataValues {
  // External links
  static Uri githubURL = Uri.parse('https://github.com');
  static Uri linkedinURL = Uri.parse('https://linkedin.com/in');
  static Uri twitterURL = Uri.parse('https://twitter.com');
  static Uri pinterestURL = Uri.parse('https://www.pinterest.com');
  static Uri telegramURL = Uri.parse('https://web.telegram.org');
  static Uri facebookURL = Uri.parse('https://facebook.com');
  static Uri instagramURL = Uri.parse('https://instagram.com');
}
