import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';

class PurchaseOrderScreen extends StatefulWidget {
  const PurchaseOrderScreen({super.key});

  @override
  State<PurchaseOrderScreen> createState() => _PurchaseOrderScreenState();
}

class _PurchaseOrderScreenState extends State<PurchaseOrderScreen> {
  final List<Map<String, dynamic>> _queuedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Purchase Order (Restock)'),
      ),
      body: Column(
        children: [
          _buildActionHeader(),
          Expanded(
            child: _queuedItems.isEmpty ? _buildEmptyState() : _buildQueueList(),
          ),
          if (_queuedItems.isNotEmpty) _buildFooterActions(),
        ],
      ),
    );
  }

  Widget _buildActionHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _addDummyItem(),
              icon: const Icon(FontAwesomeIcons.plus, size: 14),
              label: const Text('ADD PART'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                ToastUtils.showInfo('Select Excel file to import parts');
              },
              icon: const Icon(FontAwesomeIcons.fileExcel, size: 14),
              label: const Text('EXCEL'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: const BorderSide(color: AppColors.primary),
              ),
            ),
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
          Icon(FontAwesomeIcons.cartFlatbed, size: 60, color: AppColors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: 16),
          const Text('No items in batch.', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildQueueList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _queuedItems.length,
      itemBuilder: (context, index) {
        final item = _queuedItems[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('SKU: ${item['sku']} • Quantity: ${item['qty']}'),
            trailing: IconButton(
              icon: const Icon(FontAwesomeIcons.trashCan, size: 16, color: AppColors.danger),
              onPressed: () => setState(() => _queuedItems.removeAt(index)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: ElevatedButton(
        onPressed: () {
          ToastUtils.showSuccess('Stock updated successfully!');
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('CONFIRM & RESTOCK', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
      ),
    );
  }

  void _addDummyItem() {
    setState(() {
      _queuedItems.add({
        'name': 'Brake Pad Set',
        'sku': 'BRK-00${_queuedItems.length + 1}',
        'qty': 10,
      });
    });
  }
}
