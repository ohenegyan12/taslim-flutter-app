import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';
import '../utils/dialog_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _darkMode = false;
  final String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserHeader(),
            const SizedBox(height: 12),
            _buildSettingsSection(
              'Account & Profile',
              [
                _buildSettingsTile(
                  icon: FontAwesomeIcons.userPen,
                  title: 'Edit Profile',
                  subtitle: 'Name, email, and phone',
                  onTap: () {},
                ),
                _buildSettingsTile(
                  icon: FontAwesomeIcons.shieldHalved,
                  title: 'Security',
                  subtitle: 'Password, Biometrics',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSettingsSection(
              'Preferences',
              [
                _buildSettingsSwitchTile(
                  icon: FontAwesomeIcons.solidBell,
                  title: 'Push Notifications',
                  value: _pushNotifications,
                  onChanged: (val) => setState(() => _pushNotifications = val),
                  color: Colors.blue,
                ),
                _buildSettingsSwitchTile(
                  icon: FontAwesomeIcons.moon,
                  title: 'Dark Mode',
                  value: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                  color: Colors.indigo,
                ),
                _buildSettingsTile(
                  icon: FontAwesomeIcons.language,
                  title: 'Language',
                  subtitle: _language,
                  onTap: () {},
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildSettingsSection(
              'Maintenance',
              [
                _buildSettingsTile(
                  icon: FontAwesomeIcons.database,
                  title: 'Clear Cache',
                  subtitle: 'Remove temporary data',
                  onTap: () {
                    ToastUtils.showSuccess('Cache cleared successfully!');
                  },
                  color: Colors.grey,
                ),
                _buildSettingsTile(
                  icon: FontAwesomeIcons.circleQuestion,
                  title: 'Help & Support',
                  onTap: () {
                    ToastUtils.showInfo('Redirecting to support portal...');
                  },
                  color: Colors.teal,
                ),
                _buildSettingsTile(
                  icon: FontAwesomeIcons.circleInfo,
                  title: 'About App',
                  onTap: () {
                    ToastUtils.showInfo('Tasslim v1.3.0 - Built by Wigal');
                  },
                  color: Colors.blueGrey,
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () => DialogUtils.showLogoutConfirmation(context),
                icon: const Icon(FontAwesomeIcons.arrowRightFromBracket, size: 16),
                label: const Text('LOGOUT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger.withOpacity(0.1),
                  foregroundColor: AppColors.danger,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text('v1.3.0 Optimized', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Text('AD', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.primary)),
          ),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Admin User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
              Text('admin@tasslim.com', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.textSecondary, letterSpacing: 1.0),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: tiles),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color color = AppColors.primary,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 16),
          ),
          title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)) : null,
          trailing: const Icon(FontAwesomeIcons.chevronRight, size: 12, color: AppColors.textSecondary),
        ),
        if (showDivider) const Divider(height: 1, indent: 64),
      ],
    );
  }

  Widget _buildSettingsSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color color = AppColors.primary,
  }) {
    return Column(
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          secondary: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 16),
          ),
          title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          activeThumbColor: AppColors.accent,
        ),
        const Divider(height: 1, indent: 64),
      ],
    );
  }
}
