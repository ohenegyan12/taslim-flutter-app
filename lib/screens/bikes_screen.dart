import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';

class BikesScreen extends StatefulWidget {
  const BikesScreen({super.key});

  @override
  State<BikesScreen> createState() => _BikesScreenState();
}

class _BikesScreenState extends State<BikesScreen> {
  final List<Map<String, String>> _bikes = [
    {
      'plate': 'DXB-12345',
      'category': 'Private',
      'kind': 'Motorcycle',
      'location': 'Dubai',
      'color': 'Red',
      'regExp': '2025-12-31',
    },
    {
      'plate': 'SHJ-67890',
      'category': 'Commercial',
      'kind': 'Delivery',
      'location': 'Sharjah',
      'color': 'Black',
      'regExp': '2024-10-15',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bike Management'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circlePlus, size: 20),
            onPressed: () {
              ToastUtils.showInfo('Add new bike registration');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _bikes.length,
              itemBuilder: (context, index) {
                final bike = _bikes[index];
                return _buildBikeCard(bike);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search bikes...',
              prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', true),
                _buildFilterChip('Dubai', false),
                _buildFilterChip('Sharjah', false),
                _buildFilterChip('Ajman', false),
                _buildFilterChip('Abu Dhabi', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {},
        backgroundColor: Colors.white,
        selectedColor: AppColors.accent.withOpacity(0.2),
        checkmarkColor: AppColors.accent,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.accent : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: isSelected ? AppColors.accent : AppColors.border),
        ),
      ),
    );
  }

  Widget _buildBikeCard(Map<String, String> bike) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(FontAwesomeIcons.motorcycle, size: 18, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bike['plate']!,
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primary),
                        ),
                        Text(
                          '${bike['category']} • ${bike['kind']}',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    bike['location']!,
                    style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem('Color', bike['color']!),
                _buildInfoItem('Reg. Expiry', bike['regExp']!),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 16),
                  onPressed: () {
                    ToastUtils.showInfo('Manage options for ${bike['plate']}');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
      ],
    );
  }
}
