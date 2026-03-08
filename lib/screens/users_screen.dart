import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<Map<String, String>> _users = [
    {'name': 'Admin User', 'email': 'admin@tasslim.com', 'role': 'Admin'},
    {'name': 'John Staff', 'email': 'john@tasslim.com', 'role': 'Staff'},
    {'name': 'Sarah Clerk', 'email': 'sarah@tasslim.com', 'role': 'Staff'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('User Management'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.userPlus, size: 18),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          bool isAdmin = user['role'] == 'Admin';
          
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (isAdmin ? AppColors.accent : AppColors.primary).withOpacity(0.1),
                child: Icon(
                  isAdmin ? FontAwesomeIcons.userShield : FontAwesomeIcons.user,
                  size: 16,
                  color: isAdmin ? AppColors.accent : AppColors.primary,
                ),
              ),
              title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user['email']!, style: const TextStyle(fontSize: 12)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      user['role']!,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 14),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
