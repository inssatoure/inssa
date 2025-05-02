import 'package:flutter_dotenv/flutter_dotenv.dart';

String get geminiAPIKey => dotenv.env['GEMINI_API_KEY']!;
