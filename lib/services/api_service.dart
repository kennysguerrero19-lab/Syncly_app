import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Auto-select base URL depending on platform
  static String get baseUrl {
    // If running in a browser, use localhost (port 4000)
    if (kIsWeb) return 'http://localhost:4000';
    // For Android emulator use 10.0.2.2; for other platforms fallback to localhost (port 3000)
    return 'http://10.0.2.2:4000';
  }

  // Candidate base URLs to try when a request fails (helps during development)
  static List<String> get _candidates {
    if (kIsWeb) return ['http://localhost:4000', 'http://127.0.0.1:4000'];
    // Android emulator, iOS simulator, physical device (use machine LAN IP when needed)
    return ['http://10.0.2.2:4000', 'http://127.0.0.1:4000', 'http://localhost:4000'];
  }

  // Helper: try POST on candidate bases until one succeeds or return last error
  static Future<Map<String, dynamic>> _tryPost(String path, Map<String, dynamic> body, Map<String, String> headers) async {
    String lastError = '';
    for (final base in _candidates) {
      final url = Uri.parse('$base$path');
      try {
        final res = await http.post(url, headers: headers, body: jsonEncode(body));
        return _handleResponse(res);
      } catch (e) {
        lastError = e.toString();
        // try next
      }
    }
    return { 'success': false, 'error': lastError.isEmpty ? 'Network error' : lastError };
  }

  // Helper: try GET on candidate bases until one succeeds or return last error
  static Future<Map<String, dynamic>> _tryGet(String path, Map<String, String> headers) async {
    String lastError = '';
    for (final base in _candidates) {
      final url = Uri.parse('$base$path');
      try {
        final res = await http.get(url, headers: headers);
        return _handleResponse(res);
      } catch (e) {
        lastError = e.toString();
      }
    }
    return { 'success': false, 'error': lastError.isEmpty ? 'Network error' : lastError };
  }

  // Helper: try PUT on candidate bases until one succeeds or return last error
  static Future<Map<String, dynamic>> _tryPut(String path, Map<String, dynamic> body, Map<String, String> headers) async {
    String lastError = '';
    for (final base in _candidates) {
      final url = Uri.parse('$base$path');
      try {
        final res = await http.put(url, headers: headers, body: jsonEncode(body));
        return _handleResponse(res);
      } catch (e) {
        lastError = e.toString();
      }
    }
    return { 'success': false, 'error': lastError.isEmpty ? 'Network error' : lastError };
  }

  // Save token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Register
  static Future<Map<String, dynamic>> register(String name, String email, String password, { String? phone, String? birthDate, String? gender }) async {
  final body = { 'name': name, 'email': email, 'password': password };
      if (phone != null) body['phone'] = phone;
      if (birthDate != null) body['birthDate'] = birthDate;
      if (gender != null) body['gender'] = gender;
      // For registration we do NOT auto-save the token. The user should login
      // explicitly so they confirm credentials. Keep API response intact.
      final res = await _tryPost('/api/auth/register', body, { 'Content-Type': 'application/json' });
      return res;
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
  final body = { 'email': email, 'password': password };
      final res = await _tryPost('/api/auth/login', body, { 'Content-Type': 'application/json' });
      if (res['success'] && res['data'] is Map && res['data']['token'] != null) {
        await saveToken(res['data']['token']);
      }
      return res;
  }

  // Get current user (authenticated)
  static Future<Map<String, dynamic>> getCurrentUser() async {
    final token = await getToken();
    if (token == null) return { 'success': false, 'error': 'No token' };
    return await _tryGet('/api/auth/me', { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' });
  }

  // Get projects
  static Future<Map<String, dynamic>> getProjects() async {
  final token = await getToken();
      return await _tryGet('/api/projects', { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' });
  }

  // Create project
  static Future<Map<String, dynamic>> createProject(String title, String description) async {
  final token = await getToken();
      return await _tryPost('/api/projects', { 'title': title, 'description': description }, { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' });
  }

  // Update current user profile
  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> updates) async {
    final token = await getToken();
    if (token == null) return { 'success': false, 'error': 'No token' };
    return await _tryPut('/api/auth/me', updates, { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' });
  }

  static Map<String, dynamic> _handleResponse(http.Response res) {
    final status = res.statusCode;
    final body = res.body.isEmpty ? null : (() {
      try { return jsonDecode(res.body); } catch (_) { return res.body; }
    })();
    if (status >= 200 && status < 300) {
      return { 'success': true, 'data': body };
    }
    // Normalize error message
    String errorMsg;
    if (body == null) errorMsg = 'Empty response (status $status)';
    else if (body is String) errorMsg = body;
    else if (body is Map && body['msg'] != null) errorMsg = body['msg'];
    else errorMsg = body.toString();
    return { 'success': false, 'status': status, 'error': errorMsg };
  }
}
