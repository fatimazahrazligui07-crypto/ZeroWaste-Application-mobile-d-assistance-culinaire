// lib/services/ingredient_service.dart
//
// MODIFICATIONS :
//   + fetchIntervalles()      → GET /api/intervalles-temps
//   ~ fetchSuggestionsRaw()   → POST /api/recettes/suggest  (nouveaux champs)

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ingredient.dart';
import '../models/categorie.dart';
import '../models/intervalle_temps.dart';

class IngredientService {
  static const String _base =
      'https://eternity-rehire-sanitary.ngrok-free.dev/api';

  // ── Ingrédients ───────────────────────────────────────────────────────────

  Future<List<Ingredient>> fetchIngredients() async {
    final response = await http.get(Uri.parse('$_base/ingredients'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Ingredient.fromJson(json)).toList();
    }
    throw Exception('Erreur lors du chargement des ingrédients');
  }

  // ── Catégories ────────────────────────────────────────────────────────────

  Future<List<Categorie>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_base/categories'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Categorie.fromJson(json)).toList();
    }
    throw Exception('Erreur lors du chargement des catégories');
  }

  // ── Intervalles de temps (liste déroulante) ───────────────────────────────
  //
  // GET /api/intervalles-temps
  // Réponse : [{ "id": 1, "libelle": "Moins de 15 min" }, ...]

  Future<List<IntervalleTemps>> fetchIntervalles() async {
    final response =
        await http.get(Uri.parse('$_base/intervalles-temps'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data
          .map((json) => IntervalleTemps.fromJson(json))
          .toList();
    }
    throw Exception('Erreur lors du chargement des intervalles');
  }

  // ── Suggestions (ancien endpoint sans contraintes) ─────────────────────────
  //  Gardé pour compatibilité si utilisé ailleurs dans le projet.

  Future<List<dynamic>> fetchSuggestions(List<int> ingredientIds) async {
    final response = await http.post(
      Uri.parse('$_base/recettes/suggest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ingredient_ids': ingredientIds}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['suggestions'];
    }
    throw Exception('Erreur lors du chargement des suggestions');
  }

  // ── Suggestions avec contraintes ──────────────────────────────────────────
  //
  // POST /api/recettes/suggest
  // Body :
  //   ingredient_ids      : List<int>          (obligatoire)
  //   nombre_personnes    : int                (obligatoire)
  //   intervalle_temps_id : int | null         (null = pas de filtre temps)
  //   quantites_frigo     : Map<int, double>   (optionnel — clé = ingredient_id)

  Future<Map<String, dynamic>> fetchSuggestionsRaw({
    required List<Map<String, dynamic>> ingredients,
    required int nombrePersonnes,
    int? intervalleTempsId,
  }) async {
    final body = <String, dynamic>{
      'ingredients': ingredients,
      'nombre_personnes': nombrePersonnes,
    };

    if (intervalleTempsId != null) {
      body['intervalle_temps_id'] = intervalleTempsId;
    }

    final response = await http.post(
      Uri.parse('$_base/recettes/suggest'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Erreur suggestions : ${response.statusCode}');
  }
}