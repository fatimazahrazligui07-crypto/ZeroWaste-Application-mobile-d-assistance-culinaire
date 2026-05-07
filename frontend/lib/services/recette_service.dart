import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recette.dart';

class RecetteService {
  static const String _base = 'http://10.0.2.2:8000/api';

  Future<Map<String, String>> get _headers async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // GET /api/recettes
  Future<List<Recette>> fetchRecettes({
    String? search,
    String? difficulte,
  }) async {
    final headers = await _headers;
    final response = await http.get(
      Uri.parse('$_base/recettes'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      var result = data.map((r) => Recette.fromJson(r)).toList();

      if (search != null && search.isNotEmpty) {
        result = result
            .where((r) => r.nom.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }
      if (difficulte != null) {
        result = result
            .where((r) => r.niveauDifficulte == difficulte)
            .toList();
      }
      return result;
    }
    throw Exception('Erreur lors du chargement des recettes');
  }

  // GET /api/recettes/{id}
  // Envoie le token → le backend compare avec le frigo de l'utilisateur
  Future<RecetteDetail> fetchDetail(int id) async {
    final headers = await _headers;
    final response = await http.get(
      Uri.parse('$_base/recettes/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return RecetteDetail.fromJson(jsonDecode(response.body));
    }
    throw Exception('Erreur chargement recette $id : ${response.statusCode}');
  }
}