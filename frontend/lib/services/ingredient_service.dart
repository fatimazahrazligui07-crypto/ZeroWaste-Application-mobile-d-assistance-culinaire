import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ingredient.dart';
import '../models/categorie.dart';

class IngredientService {
static const String _base = 'http://10.0.2.2:8000/api';
  Future<List<Ingredient>> fetchIngredients() async {
    final response = await http.get(Uri.parse('$_base/ingredients'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Ingredient.fromJson(json)).toList();
    }
    throw Exception('Erreur lors du chargement des ingrédients');
  }

  Future<List<Categorie>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_base/categories'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Categorie.fromJson(json)).toList();
    }
    throw Exception('Erreur lors du chargement des catégories');
  }
}
