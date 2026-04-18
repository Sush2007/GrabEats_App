import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();

  // IMPORTANT: For android emulator localhost is 10.0.2.2 usually.
  // Using 10.0.2.2 for Android local server testing.
  static const String baseUrl = 'http://10.0.2.2:8000/api/auth';

  // Perform dummy google login
  static Future<bool> loginWithGoogle() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/google/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_token': 'dummy_google_token_test'
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access'];
        final refreshToken = data['refresh'];
        
        await _storage.write(key: 'access_token', value: accessToken);
        await _storage.write(key: 'refresh_token', value: refreshToken);
        return true;
      }
    } catch (e) {
      print('Login Error: $e');
    }
    return false;
  }

  // Check if a generated token exists
  static Future<bool> hasValidToken() async {
    final token = await _storage.read(key: 'access_token');
    if (token == null || token.isEmpty) return false;
    
    // Normally you would also verify token expiration or check via a backend endpoint here
    return true; 
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}
