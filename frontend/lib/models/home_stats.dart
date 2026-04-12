// lib/models/home_stats.dart
class HomeStats {
  final int nbIngredients;
  final int nbRecettes;

  HomeStats({
    required this.nbIngredients,
    required this.nbRecettes,
  });

  factory HomeStats.fromJson(Map<String, dynamic> json) => HomeStats(
        nbIngredients: json['nb_ingredients'] ?? 0,
        nbRecettes:    json['nb_recettes']    ?? 0,
      );
}
