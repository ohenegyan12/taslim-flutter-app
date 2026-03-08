import 'package:flutter/material.dart';

class AppColors {
  // Primary Theme Colors
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF34495E);
  static const Color accent = Color(0xFF3498DB);
  static const Color accentHover = Color(0xFF2980B9);
  
  // Semantic Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color danger = Color(0xFFE74C3C);
  
  // Background & Surfaces
  static const Color background = Color(0xFFF5F6FA);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFDFE6E9);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Colors.white;
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0xB2FFFFFF), // rgba(255, 255, 255, 0.7)
      Color(0x4DFFFFFF), // rgba(255, 255, 255, 0.3)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

