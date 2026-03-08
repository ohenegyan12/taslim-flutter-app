import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final List<Map<String, String>> _suppliers = [
    {'name': 'Moto Parts Inc.', 'contact': 'John Smith', 'email': 'john@motoparts.com', 'phone': '050-1234567'},
    {'name': 'Speedy Spares', 'contact': 'Alice Wong', 'email': 'alice@speedy.com', 'phone': '055-7654321'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Supplier Management'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circlePlus, size: 18),
            onPressed: () {
              ToastUtils.showInfo('Add new supplier functionality');
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _suppliers.length,
        itemBuilder: (context, index) {
          final supplier = _suppliers[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: const Icon(FontAwesomeIcons.truck, size: 14, color: AppColors.primary),
              ),
              title: Text(supplier['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Contact: ${supplier['contact']}', style: const TextStyle(fontSize: 12)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoRow(FontAwesomeIcons.envelope, supplier['email']!),
                      const SizedBox(height: 12),
                      _buildInfoRow(FontAwesomeIcons.phone, supplier['phone']!),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              ToastUtils.showInfo('Edit ${supplier['name']}');
                            },
                            icon: const Icon(FontAwesomeIcons.penToSquare, size: 14),
                            label: const Text('Edit'),
                          ),
                          const SizedBox(width: 8),
                          TextButton.icon(
                            onPressed: () {
                              ToastUtils.showWarning('Delete ${supplier['name']} requested');
                            },
                            icon: const Icon(FontAwesomeIcons.trashCan, size: 14),
                            label: const Text('Delete'),
                            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: AppColors.textPrimary)),
      ],
    );
  }
}
