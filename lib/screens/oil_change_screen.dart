import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class OilChangeScreen extends StatefulWidget {
  const OilChangeScreen({super.key});

  @override
  State<OilChangeScreen> createState() => _OilChangeScreenState();
}

class _OilChangeScreenState extends State<OilChangeScreen> {
  final List<String> _bikes = ['DXB-12345', 'SHJ-67890', 'AJM-55555'];
  String? _selectedBike;
  final TextEditingController _mileageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Oil Change Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildRecordForm(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Changes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecentChangesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordForm() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(FontAwesomeIcons.oilCan, size: 18, color: AppColors.accent),
                SizedBox(width: 10),
                Text('Record New Change', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(),
            ),
            const Text('Bike Selection', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedBike,
              decoration: _inputDecoration(hint: 'Select bike'),
              items: _bikes.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
              onChanged: (val) => setState(() => _selectedBike = val),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mileage (km)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _mileageController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(hint: 'e.g. 45000'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      TextField(
                        readOnly: true,
                        decoration: _inputDecoration(hint: '2026-03-08'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('SAVE RECORD', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentChangesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        bool isOverdue = index == 0;
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            title: Text('DXB-12345', style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary)),
            subtitle: Text('45,200 km • ${isOverdue ? "1,200 km since last" : "800 km since last"}', style: const TextStyle(fontSize: 12)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: (isOverdue ? AppColors.danger : AppColors.success).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                isOverdue ? 'Overdue' : 'Good',
                style: TextStyle(color: isOverdue ? AppColors.danger : AppColors.success, fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.background.withOpacity(0.5),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
