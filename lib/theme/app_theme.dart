import 'package:flutter/material.dart';

class AppTheme {
  // Definimos los colores principales
  static const Color primaryColor = Colors.deepOrange;
  static const Color secondaryColor = Color(
    0xFF2D3E50,
  ); // Un azul grisáceo elegante
  static const Color backgroundColor = Color(
    0xFFF8F9FA,
  ); // Blanco roto para el fondo

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // Estilo de la AppBar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // Estilo de las Tarjetas (Cards)
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Estilo de los Textos
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: secondaryColor,
        ),
        bodyLarge: TextStyle(color: Colors.black87),
      ),

      // Estilo de los Chips (Filtros)
      chipTheme: ChipThemeData(
        selectedColor: primaryColor.withOpacity(0.2),
        secondarySelectedColor: primaryColor,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Estilo de los Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
