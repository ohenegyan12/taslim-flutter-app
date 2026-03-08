import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../providers/auth_provider.dart';
import '../providers/stats_provider.dart';
import '../constants/app_colors.dart';
import '../utils/toast_utils.dart';
import '../utils/dialog_utils.dart';
import 'inventory_screen.dart';
import 'issue_part_screen.dart';
import 'bikes_screen.dart';
import 'mechanics_screen.dart';
import 'reports_screen.dart';
import 'riders_screen.dart';
import 'oil_change_screen.dart';
import 'bike_history_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';
import 'purchase_order_screen.dart';
import 'suppliers_screen.dart';
import 'mechanic_history_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const DashboardHome(),
    const InventoryScreen(),
    const IssuePartScreen(),
    const ReportsScreen(),
    const BikeHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TASSLIM'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circleUser, size: 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context, user),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildDrawer(BuildContext context, user) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(FontAwesomeIcons.user, color: AppColors.primary),
            ),
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text('Role: ${user?.role ?? ""}'),
          ),
          _buildDrawerTabItem(FontAwesomeIcons.tableCellsLarge, 'Dashboard', 0),
          _buildDrawerPageItem(FontAwesomeIcons.cartShopping, 'Purchase Orders', const PurchaseOrderScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.truckFast, 'Suppliers', const SuppliersScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.motorcycle, 'Bikes', const BikesScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.idCard, 'Riders', const RidersScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.userGear, 'Mechanics', const MechanicsScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.clockRotateLeft, 'Mechanic History', const MechanicHistoryScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.oilCan, 'Oil Changes', const OilChangeScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.usersGear, 'User Management', const UsersScreen()),
          _buildDrawerPageItem(FontAwesomeIcons.gear, 'Settings', const SettingsScreen()),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rightFromBracket, size: 20, color: AppColors.danger),
            title: const Text('Logout', style: TextStyle(color: AppColors.danger, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context); // Close drawer
              DialogUtils.showLogoutConfirmation(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerTabItem(IconData icon, String title, int index) {
    bool isSelected = _currentIndex == index;
    return ListTile(
      leading: Icon(icon, size: 20, color: isSelected ? AppColors.accent : AppColors.secondary),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          color: isSelected ? AppColors.accent : AppColors.primary,
        ),
      ),
      onTap: () {
        setState(() => _currentIndex = index);
        Navigator.pop(context);
      },
      selected: isSelected,
    );
  }

  Widget _buildDrawerPageItem(IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppColors.secondary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 65,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(FontAwesomeIcons.tableCellsLarge, 'Home', 0),
          _buildNavItem(FontAwesomeIcons.boxesStacked, 'Stock', 1),
          _buildNavItem(FontAwesomeIcons.circlePlus, 'Issue', 2),
          _buildNavItem(FontAwesomeIcons.chartBar, 'Reports', 3),
          _buildNavItem(FontAwesomeIcons.clockRotateLeft, 'History', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StatsProvider>(context, listen: false).fetchDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final statsProvider = Provider.of<StatsProvider>(context);
    final user = auth.user;
    final stats = statsProvider.stats;

    return RefreshIndicator(
      onRefresh: () async {
        await statsProvider.fetchDashboardStats();
        ToastUtils.showInfo('Dashboard updated');
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, ${user?.name ?? 'User'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Role: ${user?.role.toUpperCase() ?? ''}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildStatCard(
                  title: 'Inventory',
                  value: stats?['totalProducts']?.toString() ?? '...',
                  icon: FontAwesomeIcons.boxesStacked,
                  color: Colors.blue,
                ),
                _buildStatCard(
                  title: 'Low Stock',
                  value: stats?['lowStockItems']?.toString() ?? '...',
                  icon: FontAwesomeIcons.triangleExclamation,
                  color: Colors.orange,
                ),
                _buildStatCard(
                  title: 'Suppliers',
                  value: stats?['activeSuppliers']?.toString() ?? '...',
                  icon: FontAwesomeIcons.truckFast,
                  color: Colors.green,
                ),
                _buildStatCard(
                  title: 'System Users',
                  value: stats?['totalUsers']?.toString() ?? '...',
                  icon: FontAwesomeIcons.usersGear,
                  color: Colors.purple,
                ),
              ],
            ),
            
            if (statsProvider.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Offline Mode: Using cached data',
                  style: TextStyle(color: Colors.orange.shade700, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            
            const SizedBox(height: 32),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildRecentActivity(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.accent.withOpacity(0.1),
              child: const Icon(FontAwesomeIcons.receipt, size: 14, color: AppColors.accent),
            ),
            title: const Text('Parts Issuance #1024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: const Text('Mechanic: John Doe • Bike: DX-940', style: TextStyle(fontSize: 11)),
            trailing: const Text('AED 450', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary)),
          ),
        );
      },
    );
  }
}
