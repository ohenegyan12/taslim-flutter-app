import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class BikeHistoryScreen extends StatefulWidget {
  const BikeHistoryScreen({super.key});

  @override
  State<BikeHistoryScreen> createState() => _BikeHistoryScreenState();
}

class _BikeHistoryScreenState extends State<BikeHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showHistory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bike Service History'),
        actions: [
          if (_showHistory)
            IconButton(
              icon: const Icon(FontAwesomeIcons.print, size: 18),
              onPressed: () {},
            ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchArea(),
          Expanded(
            child: _showHistory ? _buildHistoryTimeline() : _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Search Bike Plate', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'e.g. DXB-12345',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 14),
                    filled: true,
                    fillColor: AppColors.background.withOpacity(0.5),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => setState(() => _showHistory = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(80, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('View'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.motorcycle, size: 80, color: AppColors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: 20),
          const Text(
            'Search a bike plate to view its\ncomplete service lifecycle.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTimeline() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatsSummary(),
        const SizedBox(height: 24),
        const Text('Service Lifecycle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
        const SizedBox(height: 16),
        _buildTimelineItem(
          title: 'Parts Issued',
          description: 'Front Brake Pads, Engine Oil Filter',
          date: 'Mar 08, 2026',
          mechanic: 'John Doe',
          type: 'service',
        ),
        _buildTimelineItem(
          title: 'Oil Change',
          description: '10W-40 Synthetic Oil at 45,200 km',
          date: 'Feb 24, 2026',
          mechanic: 'Robert Smith',
          type: 'oil',
        ),
        _buildTimelineItem(
          title: 'Routine Maintenance',
          description: 'Chain tightening and sprocket inspection',
          date: 'Feb 10, 2026',
          mechanic: 'John Doe',
          type: 'service',
        ),
      ],
    );
  }

  Widget _buildStatsSummary() {
    return Row(
      children: [
        Expanded(child: _buildStatMiniCard('Services', '12', FontAwesomeIcons.wrench, Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatMiniCard('Oil Changes', '5', FontAwesomeIcons.oilCan, Colors.orange)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatMiniCard('Last Visit', '8d ago', FontAwesomeIcons.calendarCheck, Colors.teal)),
      ],
    );
  }

  Widget _buildStatMiniCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required String description,
    required String date,
    required String mechanic,
    required String type,
  }) {
    Color typeColor = type == 'oil' ? Colors.orange : Colors.blue;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: typeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [BoxShadow(color: typeColor.withOpacity(0.3), blurRadius: 4)],
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: AppColors.border,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: typeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: typeColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  const SizedBox(height: 4),
                  Text(description, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.userGear, size: 10, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text(mechanic, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
