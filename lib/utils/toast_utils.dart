import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_colors.dart';

class ToastUtils {
  static void showSuccess(String message) {
    _show(message, AppColors.success);
  }

  static void showError(String message) {
    _show(message, AppColors.danger, isLong: true);
  }

  static void showInfo(String message) {
    _show(message, AppColors.primary);
  }

  static void showWarning(String message) {
    _show(message, Colors.orange);
  }

  static void _show(String message, Color bgColor, {bool isLong = false}) {
    try {
      Fluttertoast.showToast(
        msg: message,
        toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: isLong ? 3 : 2,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      // Fallback for when the plugin isn't registered (MissingPluginException)
      debugPrint('Toast Fallback: $message');
    }
  }
}
