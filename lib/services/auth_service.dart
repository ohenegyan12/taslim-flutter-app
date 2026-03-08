import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class AuthService {
  // Use 10.0.2.2 for Android emulator, localhost for iOS/Web/Desktop
  static const String _apiBaseUrl = 'http://10.0.2.2:4000/api/v1'; 
  static const String _apiBaseUrlIos = 'http://localhost:4000/api/v1';
  static const String _sessionKey = 'spi_session';
  
  final _storage = const FlutterSecureStorage();
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    // IMMEDIATE BYPASS Check - Don't even wait for network timeout if using dev credentials
    if ((cleanEmail == 'admin' && cleanPassword.toLowerCase() == 'admin') || 
        (cleanEmail == 'staff' && cleanPassword.toLowerCase() == 'staff')) {
      return await _localLoginFallback(cleanEmail, cleanPassword, 'Bypassed Network');
    }

    // Determine the correct URL based on platform if needed, 
    // but for now let's try to be smart about the connection.
    try {
      String baseUrl;
      if (kIsWeb) {
        baseUrl = 'http://localhost:4000/api/v1';
      } else if (Platform.isAndroid) {
        baseUrl = 'http://10.0.2.2:4000/api/v1';
      } else {
        baseUrl = 'http://localhost:4000/api/v1';
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': cleanEmail, 'password': cleanPassword}),
      ).timeout(const Duration(seconds: 5));

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        final userData = result['data']['user'];
        final token = result['data']['token'];
        
        String nameValue = userData['name'] ?? '';
        if (nameValue.isEmpty) {
          nameValue = '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}'.trim();
        }

        final user = User(
          id: userData['id'],
          name: nameValue,
          email: userData['email'] ?? '',
          role: (userData['role'] ?? 'staff').toString().toLowerCase(),
          token: token,
        );

        await _saveSession(user);
        return {'success': true, 'user': user};
      }
      
      // Backend error structure: { success: false, error: { code: '...', message: '...' } }
      final errorMessage = result['error']?['message'] ?? result['message'] ?? 'Invalid credentials';
      return {'success': false, 'message': errorMessage};
    } catch (e) {
      debugPrint('Login attempt failed with error: $e');
      // Improved fallback for development
      return await _localLoginFallback(cleanEmail, cleanPassword, e.toString());
    }
  }

  Future<Map<String, dynamic>> _localLoginFallback(String email, String password, String error) async {
    final e = email.toLowerCase().trim();
    final p = password.toLowerCase().trim();
    
    // Check for hardcoded credentials or any common dev combinations
    bool isDevMatch = (e == 'admin' && p == 'admin') || 
                     (e == 'staff' && p == 'staff') ||
                     (e == 'admin' && p == 'admin123') ||
                     (e == 'admin@tasslim.com' && p == 'admin') ||
                     (e == 'test@test.com' && p == 'test');

    if (isDevMatch) {
      debugPrint('Bypassing authentication for dev user: $e');
      final user = User(
        id: e.contains('admin') ? 'offline-admin' : 'offline-staff',
        name: e.contains('admin') ? 'System Administrator' : 'Staff Member',
        email: e,
        role: e.contains('admin') ? 'admin' : 'staff',
        token: 'offline-token',
      );
      await _saveSession(user);
      return {
        'success': true, 
        'user': user, 
        'message': 'Logged in via Offline Bypass'
      };
    }
    
    debugPrint('Offline bypass failed for: "$e" / "$p"');
    return {
      'success': false, 
      'message': 'Server Unreachable: $error. \n\nHint: Use "admin"/"admin" for offline access.'
    };
  }

  Future<void> _saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, jsonEncode(user.toJson()));
    if (user.token != null) {
      await _storage.write(key: 'jwt_token', value: user.token);
    }
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = prefs.getString(_sessionKey);
    if (sessionData == null) return null;
    return User.fromJson(jsonDecode(sessionData));
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    await _storage.delete(key: 'jwt_token');
  }
}
