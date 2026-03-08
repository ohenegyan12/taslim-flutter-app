import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class MechanicHistoryScreen extends StatefulWidget {
  const MechanicHistoryScreen({super.key});

  @override
  State<MechanicHistoryScreen> createState() => _MechanicHistoryScreenState();
}

class _MechanicHistoryScreenState extends State<MechanicHistoryScreen> {
  final List<String> _mechanics = ['John Doe', 'Robert Smith', 'Mike Wilson'];
  String? _selectedMechanic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mechanic History'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.print, size: 18),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          if (_selectedMechanic != null) _buildMechanicInfo(),
          Expanded(
            child: _selectedMechanic == null ? _buildEmptyState() : _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Mechanic', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: _selectedMechanic,
            decoration: InputDecoration(
              hintText: 'Choose a mechanic',
              filled: true,
              fillColor: AppColors.background.withOpacity(0.5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            items: _mechanics.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
            onChanged: (val) => setState(() => _selectedMechanic = val),
          ),
        ],
      ),
    );
  }

  Widget _buildMechanicInfo() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_selectedMechanic!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(FontAwesomeIcons.solidIdBadge, size: 12, color: Colors.white70),
              SizedBox(width: 6),
              Text('Code: MECH-001', style: TextStyle(color: Colors.white70, fontSize: 12)),
              SizedBox(width: 16),
              Icon(FontAwesomeIcons.solidEnvelope, size: 12, color: Colors.white70),
              SizedBox(width: 6),
              Text('active', style: TextStyle(color: Colors.white70, fontSize: 12)),
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
          Icon(FontAwesomeIcons.userGear, size: 60, color: AppColors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text('Search for a mechanic to see history', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
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
                    const Text('Mar 08, 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4)),
                      child: const Text('#TX-1025', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Bike: DXB-12345', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildItemBadge('2x Brake Pads'),
                    _buildItemBadge('1x Oil Filter'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItemBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(text, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
