// lib/services/home_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home_stats.dart';
import '../models/recette.dart';

class HomeService {
static const String _base = 'http://192.168.0.104:8000/api';  // 10.0.2.2 = localhost depuis l'émulateur Android
  // Pour iPhone simulateur → 127.0.0.1

  // Token JWT stocké après login
  String? _token;

  void setToken(String token) => _token = token;

  Map<String, String> get _headers => {
    'Content-Type':  'application/json',
    'Accept':        'application/json',
    'Authorization': 'Bearer $_token',
  };

  Future<Map<String, dynamic>> fetchHome() async {
    final response = await http.get(
      Uri.parse('$_base/home'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'stats':    HomeStats.fromJson(data['stats']),
        'recettes': (data['recettes'] as List)
            .map((r) => Recette.fromJson(r))
            .toList(),
      };
    }
    throw Exception('Erreur: ${response.statusCode}');
  }
}