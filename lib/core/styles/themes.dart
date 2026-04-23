import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFD98F39);
const Color secondPrimaryColor = Color(0xFF18222D);
const Color accentColor = Color(0xFFBE3D2A);
const Color pageBackgroundColor = Colors.white;
const Color cardSurfaceColor = Color(0xFFEDEDED);
const Color mutedSurfaceColor = Color(0xFFEEF1F4);
const Color secondTextColor = Color(0xFF6B7280);
const Color borderColor = Color(0xFFE3E8EE);
const Color containerColor = Color(0xFFF3F5F7);
const Color successColor = Color(0xFF2C8C5A);

class ThemeService {
  final lightTheme = ThemeData(
    scaffoldBackgroundColor: pageBackgroundColor,
    primaryColor: primaryColor,
    fontFamily: 'Cairo',
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      showUnselectedLabels: false,
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.dark(),
      buttonColor: Colors.black87,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black87,
      dividerColor: primaryColor,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      surface: cardSurfaceColor,
    ),
  );
}
