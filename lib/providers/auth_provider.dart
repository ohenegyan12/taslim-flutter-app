import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isInitialLoading = true;
  bool _isActionLoading = false;

  User? get user => _user;
  bool get isInitialLoading => _isInitialLoading;
  bool get isActionLoading => _isActionLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _user = await _authService.getCurrentUser();
    _isInitialLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isActionLoading = true;
    notifyListeners();

    final result = await _authService.login(email, password);
    
    if (result['success']) {
      _user = result['user'];
    }
    
    _isActionLoading = false;
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
