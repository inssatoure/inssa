import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:quick_resume_creator/quick_resume_creator.dart';
import 'package:quick_resume_creator/prefs/user_prefs.dart';
import 'package:quick_resume_creator/service/get_it/get_it.dart';
import 'package:quick_resume_creator/utils/env.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await dotenv.load(fileName: '.env');

  Gemini.init(
    apiKey: geminiAPIKey, //#API_KEY
    enableDebugging: true,
  );

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        // apiKey: "AIzaSyDaY6q8mrIftfcwWRFqVRWwOuGqOlbbTTU",
        // authDomain: "quick-resume-creator.firebaseapp.com",
        // projectId: "quick-resume-creator",
        // storageBucket: "quick-resume-creator.appspot.com",
        // messagingSenderId: "822231801330",
        // appId: "1:822231801330:web:418676f5172867b3abdf6b",
        // measurementId: "G-M9PN2EGZ27",
        apiKey: "AIzaSyBYfcWNpA-RUtqaA_cwsa3k1-6oHPzWsIo",
        authDomain: "portfolio-web-ad6f6.firebaseapp.com",
        projectId: "portfolio-web-ad6f6",
        storageBucket: "portfolio-web-ad6f6.firebasestorage.app",
        messagingSenderId: "952845585342",
        appId: "1:952845585342:web:b4ee5b7ffb31a3c570c7ef",
        measurementId: "G-5LMH0CYRDG"),
  );
  await initializeDateFormatting('en', null);
  loadPrefs();
  GetItService.initializeService();

  runApp(const QuickResumeCreator());
}
