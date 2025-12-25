import 'package:flutter/material.dart';

class AppTheme {
  // Color principal naranja vibrante, típico de festividades
  static const Color primaryColor = Colors.deepOrange;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      // Fondo "Nube" para que las tarjetas blancas resalten
      scaffoldBackgroundColor: const Color(0xFFF5F7F9),

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 0, // Quitamos la sombra estándar
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        clipBehavior: Clip.antiAlias, // Para que la imagen respete las esquinas
      ),

      // Estilo de los textos principales
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          letterSpacing: -0.5,
        ),
      ),
    );
  }
}
