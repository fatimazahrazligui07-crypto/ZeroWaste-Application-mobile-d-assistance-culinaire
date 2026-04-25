import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  //final String _baseUrl = 'http://10.0.2.2:8000/api'; // Remplacez par l'URL de votre backend Laravel
  // Pour Android Emulator, utilisez 10.0.2.2. Pour iOS Simulator ou un appareil réel, utilisez l'IP de votre machine.
 static const String _baseUrl = 'https://hurry-unbend-eradicate.ngrok-free.dev/api';
  Future<Map<String, dynamic>> signup(
      String firstname, String? lastname, String username, String email, String password, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      //Uri.parse('$_baseUrl/login'),
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    return _handleResponse(response);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null) {
      await http.post(
        Uri.parse('$_baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      await prefs.remove('access_token');
    }
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final responseData = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (responseData.containsKey('access_token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', responseData['access_token']);
      }
      return {'success': true, 'data': responseData};
    } else if (response.statusCode == 422) { // Validation errors from Laravel
      return {'success': false, 'message': 'Erreur de validation', 'errors': responseData['errors']};
    } else {
      return {'success': false, 'message': responseData['message'] ?? 'Une erreur est survenue'};
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}