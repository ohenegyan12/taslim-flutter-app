import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants/app_colors.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Map<String, dynamic>> _inventory = [
    {
      'sku': 'BRK-001',
      'name': 'Brake Pad Set',
      'category': 'Brakes',
      'stock': 45,
      'unit': 'pc',
      'price': 120.0,
      'minStock': 10,
    },
    {
      'sku': 'OIL-502',
      'name': 'Engine Oil 10W40',
      'category': 'Lubricants',
      'stock': 8,
      'unit': 'Ltr',
      'price': 45.0,
      'minStock': 15,
    },
    {
      'sku': 'FLT-102',
      'name': 'Air Filter',
      'category': 'Filters',
      'stock': 20,
      'unit': 'pc',
      'price': 35.0,
      'minStock': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inventory Management'),
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
              itemCount: _inventory.length,
              itemBuilder: (context, index) {
                final item = _inventory[index];
                return _buildInventoryCard(item);
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
              hintText: 'Search items by name or SKU...',
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
                _buildFilterChip('All Items', true),
                _buildFilterChip('Low Stock', false),
                _buildFilterChip('Out of Stock', false),
                _buildFilterChip('Brakes', false),
                _buildFilterChip('Engine', false),
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

  Widget _buildInventoryCard(Map<String, dynamic> item) {
    bool isLowStock = item['stock'] <= item['minStock'];
    
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppColors.primary),
                      ),
                      Text(
                        'SKU: ${item['sku']} • ${item['category']}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isLowStock ? AppColors.danger : AppColors.success).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isLowStock ? 'LOW STOCK' : 'IN STOCK',
                    style: TextStyle(
                      color: isLowStock ? AppColors.danger : AppColors.success,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
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
                _buildInfoItem('Quantity', '${item['stock']} ${item['unit']}'),
                _buildInfoItem('Unit Price', 'AED ${item['price']}'),
                _buildInfoItem('Total Value', 'AED ${item['stock'] * item['price']}'),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 16),
                  onPressed: () {},
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
