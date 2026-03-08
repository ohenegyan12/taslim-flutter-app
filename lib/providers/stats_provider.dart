import 'package:flutter/material.dart';
import '../services/reports_service.dart';

class StatsProvider with ChangeNotifier {
  final ReportsService _reportsService = ReportsService();
  
  Map<String, dynamic>? _stats;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDashboardStats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _reportsService.getDashboardStats();

    if (result['success']) {
      _stats = result['data'];
    } else {
      _error = result['message'];
    }

    _isLoading = false;
    notifyListeners();
  }
}
