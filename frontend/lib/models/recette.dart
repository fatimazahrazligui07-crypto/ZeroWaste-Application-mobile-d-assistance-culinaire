// lib/models/recette.dart
class Recette {
  final int id;
  final String nom;
  final String niveauDifficulte;
  final int tempsPreparation;
  final int compatibilite; // 0-100 selon les ingrédients du frigo
  final String? imageUrl;
  final int nbManquants; // nombre d'ingrédients manquants

  Recette({
    required this.id,
    required this.nom,
    required this.niveauDifficulte,
    required this.tempsPreparation,
    required this.compatibilite,
    this.imageUrl,
    this.nbManquants = 0,
  });

  factory Recette.fromJson(Map<String, dynamic> json) => Recette(
    id:               json['id'],
    nom:              json['nom'],
    niveauDifficulte: json['niveauDifficulte'] ?? json['niveau_difficulte'] ?? '',
    tempsPreparation: json['tempsPreparation'] ?? json['temps_preparation'] ?? 0,
    compatibilite:    json['compatibilite'] ?? 0,
    imageUrl:         json['image_url'],
    nbManquants:      json['manquants'] ?? json['nb_manquants'] ?? 0,
  );
}

// ─── Détail complet d'une recette ─────────────────────────────────────────────

class RecetteDetail {
  final int id;
  final String nom;
  final String? description;
  final String niveauDifficulte;
  final int tempsPreparation;
  final int? tempsCuisson;
  final String? imageUrl;
  final int compatibilite;
  final List<String> instructions;
  final List<IngredientLigne> ingredients;

  RecetteDetail({
    required this.id,
    required this.nom,
    this.description,
    required this.niveauDifficulte,
    required this.tempsPreparation,
    this.tempsCuisson,
    this.imageUrl,
    required this.compatibilite,
    required this.instructions,
    required this.ingredients,
  });

  int get nbPersonnes => 4;
  int get tempsTotal => tempsPreparation + (tempsCuisson ?? 0);

  factory RecetteDetail.fromJson(Map<String, dynamic> json) => RecetteDetail(
    id:               json['id'],
    nom:              json['nom'],
    description:      json['description'],
    niveauDifficulte: json['niveauDifficulte'] ?? json['niveau_difficulte'] ?? '',
    tempsPreparation: json['tempsPreparation'] ?? json['temps_preparation'] ?? 0,
    tempsCuisson:     json['tempsCuisson']     ?? json['temps_cuisson'],
    imageUrl:         json['image_url'],
    compatibilite:    json['compatibilite'] ?? 0,
    instructions: (json['instructions'] is List)
        ? (json['instructions'] as List).map((e) => e.toString()).toList()
        : [],
    ingredients: (json['ingredients'] is List)
        ? (json['ingredients'] as List)
        .map((e) => IngredientLigne.fromJson(e))
        .toList()
        : [],
  );
}

// ─── Ligne d'ingrédient dans le détail ───────────────────────────────────────

class IngredientLigne {
  final int id;
  final String nom;
  final String quantite;
  final bool disponible;

  IngredientLigne({
    required this.id,
    required this.nom,
    required this.quantite,
    required this.disponible,
  });

  factory IngredientLigne.fromJson(Map<String, dynamic> json) => IngredientLigne(
    id:         json['id'],
    nom:        json['nom'],
    quantite:   json['quantite'] ?? '',
    disponible: json['disponible'] ?? false,
  );
}
