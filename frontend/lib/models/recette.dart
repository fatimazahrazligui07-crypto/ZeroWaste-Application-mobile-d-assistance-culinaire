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
    niveauDifficulte: json['niveau_difficulte'] ?? '',
    tempsPreparation: json['temps_preparation'] ?? 0,
    compatibilite:    json['compatibilite'] ?? 0,
    imageUrl:         json['image_url'],
    nbManquants:      json['nb_manquants'] ?? 0,
  );
}