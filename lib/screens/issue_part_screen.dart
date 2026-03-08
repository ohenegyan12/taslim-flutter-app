import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';

class IssuePartScreen extends StatefulWidget {
  const IssuePartScreen({super.key});

  @override
  State<IssuePartScreen> createState() => _IssuePartScreenState();
}

class _IssuePartScreenState extends State<IssuePartScreen> {
  String? _selectedBike;
  String? _selectedMechanic;
  final List<Map<String, String>> _selectedParts = [];

  final List<String> _bikes = ['DXB-12345', 'SHJ-67890', 'AJM-55555', 'AUH-99999'];
  final List<String> _mechanics = ['John Doe', 'Robert Smith', 'Ahmed Ali', 'Steve Job'];
  
  void _addPartRow() {
    setState(() {
      _selectedParts.add({'sku': '', 'name': '', 'qty': '1'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Issue Part (Mapping)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              title: '1. Select Bike',
              icon: FontAwesomeIcons.motorcycle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Plate Number', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedBike,
                    hint: const Text('Choose a bike'),
                    decoration: _inputDecoration(),
                    items: _bikes.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    onChanged: (val) => setState(() => _selectedBike = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: '2. Tracking Details',
              icon: FontAwesomeIcons.idCard,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rider Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                            const SizedBox(height: 8),
                            TextField(decoration: _inputDecoration(hint: 'e.g. Ahmed')),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rider Phone', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                            const SizedBox(height: 8),
                            TextField(decoration: _inputDecoration(hint: '05x xxx xxxx')),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Receiver Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        hint: const Text('Who is receiving the part?'),
                        decoration: _inputDecoration(),
                        items: ['Self', 'Mechanic', 'Rider', 'Other'].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                        onChanged: (val) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: '3. Assign Mechanic',
              icon: FontAwesomeIcons.wrench,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mechanic Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedMechanic,
                    hint: const Text('Choose a mechanic'),
                    decoration: _inputDecoration(),
                    items: _mechanics.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                    onChanged: (val) => setState(() => _selectedMechanic = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: '4. Parts to Issue',
              icon: FontAwesomeIcons.boxesStacked,
              child: Column(
                children: [
                  if (_selectedParts.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border, style: BorderStyle.solid),
                      ),
                      child: Column(
                        children: [
                          Icon(FontAwesomeIcons.circleExclamation, color: AppColors.textSecondary.withOpacity(0.5), size: 30),
                          const SizedBox(height: 12),
                          const Text('No parts added yet', style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ..._selectedParts.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(decoration: _inputDecoration(hint: 'Part SKU or Name')),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: _inputDecoration(hint: 'Qty'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.trashCan, color: AppColors.danger, size: 16),
                            onPressed: () => setState(() => _selectedParts.removeAt(idx)),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _addPartRow,
                    icon: const Icon(FontAwesomeIcons.plus, size: 14),
                    label: const Text('Add Part Row'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_selectedBike == null) {
                  ToastUtils.showError('Please select a bike first');
                  return;
                }
                if (_selectedParts.isEmpty) {
                  ToastUtils.showError('Add at least one part');
                  return;
                }
                
                // Placeholder for real API call
                ToastUtils.showSuccess('Part issuance recorded successfully!');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
              ),
              child: const Text('CONFIRM ISSUANCE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
            ),
            const SizedBox(height: 100), // Space for bottom nav or scrolling
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Widget child}) {
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
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(),
            ),
            child,
          ],
        ),
      ),
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
