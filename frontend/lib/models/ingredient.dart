import 'package:flutter/material.dart';

class Ingredient {
  final String id;
  final String nom;
  final String categorieId;
  final String? svgIcon;
  final Color? couleur;
  bool selectionne;

  Ingredient({
    required this.id,
    required this.nom,
    required this.categorieId,
    this.svgIcon,
    this.couleur,
    this.selectionne = false,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id:          json['id'].toString(),
      nom:         json['nom'] ?? '',
      categorieId: json['categorie_id']?.toString() ?? '',
      svgIcon:     json['svgIcon'] ?? json['svg_icon'],
      couleur:     json['couleur'] != null ? _hexToColor(json['couleur']) : null,
    );
  }

  static Color _hexToColor(String hex) {
    final h = hex.replaceAll('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}
