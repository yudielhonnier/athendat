import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFECEFF4), // Light blue-grey
    primaryContainer: Color(0xFFD8DEE9), // Slightly darker blue-grey
    secondary: Color(0xFFC0C8D7), // Mid-tone blue-grey
    secondaryContainer:
        Color(0xFFE5E9F0), // Light blue-grey, slightly darker than primary
    surface: Color(0xFFF8F9FB), // Almost white
    error: Color(0xFFD32F2F), // Standard Material red for consistency

    onPrimary: Color(0xFF2E3440), // Dark grey, almost black
    onPrimaryContainer: Color(0xFF4C566A), // Dark blue-grey
    onSecondary: Color(0xFF2E3440), // Dark grey, almost black
    onSecondaryContainer: Color(0xFF3B4252), // Dark blue-grey
    onSurface: Color(0xFF2E3440), // Dark grey, almost black
    onError: Color(0xFFFFFFFF), // White

    // Additional colors for completeness
    tertiary: Color.fromARGB(255, 66, 106, 146), // Light blue
    onTertiary: Colors.blue, // Dark grey, almost black
    tertiaryContainer: Color(0xFFB5C8D9), // Very light blue
    onTertiaryContainer: Color(0xFF2E3440), // Dark grey, almost black

    outline: Color(0xFF4C566A), // Dark blue-grey for outlines
    shadow:  Color.fromARGB(255, 1, 22, 40), // 25% opaque black for shadows
    inverseSurface: Color(0xFF2E3440), // Dark grey, almost black
    onInverseSurface: Color(0xFFECEFF4), // Light blue-grey
    inversePrimary: Color(0xFF81A1C1), // Light blue
    surfaceTint: Color(0xFFD8DEE9), // Slightly darker blue-grey
  ),
);

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 6, 13, 24),
      // primary: Color.fromARGB(255,16,23,35),
      // primary: Colors.blue,
      primaryContainer: Color.fromARGB(255, 17, 24, 36),
      secondary: Color.fromARGB(255, 32, 40, 53),
      secondaryContainer: Color.fromARGB(255, 17, 23, 35),
      surface: Color.fromARGB(255, 6, 13, 24),
      error: Colors.red,
      onPrimary: Color.fromARGB(255, 199, 201, 203),
      onSecondary: Color.fromARGB(255, 199, 201, 203),
      onSurface: Color.fromARGB(255, 199, 201, 203),
      onError: Colors.white,
      brightness: Brightness.dark,
    ));
