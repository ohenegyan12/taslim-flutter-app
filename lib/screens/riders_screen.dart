import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class RidersScreen extends StatefulWidget {
  const RidersScreen({super.key});

  @override
  State<RidersScreen> createState() => _RidersScreenState();
}

class _RidersScreenState extends State<RidersScreen> {
  final List<Map<String, String>> _riders = [
    {
      'name': 'Ahmed Ali',
      'phone': '050 111 2222',
      'plates': 'DXB-12345, SHJ-67890',
    },
    {
      'name': 'Omar Hassan',
      'phone': '055 333 4444',
      'plates': 'AJM-55555',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Riders Information'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circlePlus, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _riders.length,
              itemBuilder: (context, index) {
                final rider = _riders[index];
                return _buildRiderCard(rider);
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
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search rider or plate...',
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
    );
  }

  Widget _buildRiderCard(Map<String, String> rider) {
    List<String> plates = rider['plates']!.split(',').map((p) => p.trim()).toList();

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rider['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.phone, size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 6),
                        Text(
                          rider['phone']!,
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.fileLines, size: 18, color: AppColors.accent),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: plates.map((plate) => _buildPlateBadge(plate)).toList(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.penToSquare, size: 14),
                  label: const Text('Edit'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.trashCan, size: 14, color: AppColors.danger),
                  label: const Text('Delete', style: TextStyle(color: AppColors.danger)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateBadge(String plate) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Text(
        plate,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primary),
      ),
    );
  }
}
