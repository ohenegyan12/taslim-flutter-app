import 'dart:convert';
import 'api_service.dart';

class ReportsService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _apiService.get('/reports/dashboard-stats');
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        return {
          'success': true,
          'data': result['data'],
        };
      }
      return {
        'success': false,
        'message': result['error']?['message'] ?? 'Failed to load stats',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
