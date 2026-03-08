import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';
import 'toast_utils.dart';

class DialogUtils {
  static Future<void> showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Column(
            children: [
              Icon(FontAwesomeIcons.rightFromBracket, color: AppColors.danger, size: 40),
              SizedBox(height: 16),
              Text(
                'Confirm Logout',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to log out of your session? You will need to login again to access your data.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Provider.of<AuthProvider>(context, listen: false).logout();
                ToastUtils.showInfo('Logged out successfully');
                
                // Clear all routes and go back to splash/login
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
