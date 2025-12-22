import 'package:finde_cat/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('es', null); // Para fechas en español
  runApp(const FindeCatApp());
}

class FindeCatApp extends StatelessWidget {
  const FindeCatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finde Cat',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // <--- CAMBIA ESTO
      home: const HomeScreen(),
    );
  }
}
