// lib/services/recette_service.dart
import '../models/recette.dart';

class RecetteService {
  // ── Données mockées (à remplacer par des appels HTTP quand le backend est prêt) ──
  static final List<Recette> _mockRecettes = [
    Recette(
      id: 1,
      nom: 'Tajine Poulet Citron',
      niveauDifficulte: 'Facile',
      tempsPreparation: 45,
      compatibilite: 100,
      nbManquants: 0,
      imageUrl: 'https://images.unsplash.com/photo-1511690743698-d9d85f2fbf38?w=600',
    ),
    Recette(
      id: 2,
      nom: 'Couscous aux Légumes',
      niveauDifficulte: 'Moyen',
      tempsPreparation: 90,
      compatibilite: 85,
      nbManquants: 2,
      imageUrl: 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=600',
    ),
    Recette(
      id: 3,
      nom: 'Harira Marocaine',
      niveauDifficulte: 'Facile',
      tempsPreparation: 55,
      compatibilite: 70,
      nbManquants: 1,
      imageUrl: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600',
    ),
    Recette(
      id: 4,
      nom: 'Pastilla au Poulet',
      niveauDifficulte: 'Difficile',
      tempsPreparation: 75,
      compatibilite: 60,
      nbManquants: 3,
      imageUrl: 'https://images.unsplash.com/photo-1574484284002-952d92456975?w=600',
    ),
    Recette(
      id: 5,
      nom: 'Zaalouk d\'Aubergines',
      niveauDifficulte: 'Facile',
      tempsPreparation: 35,
      compatibilite: 90,
      nbManquants: 0,
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600',
    ),
    Recette(
      id: 6,
      nom: 'Kefta aux Tomates',
      niveauDifficulte: 'Facile',
      tempsPreparation: 50,
      compatibilite: 75,
      nbManquants: 1,
      imageUrl: 'https://images.unsplash.com/photo-1529042410759-befb1204b468?w=600',
    ),
    Recette(
      id: 7,
      nom: 'Mrouzia d\'Agneau',
      niveauDifficulte: 'Moyen',
      tempsPreparation: 110,
      compatibilite: 50,
      nbManquants: 4,
      imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600',
    ),
    Recette(
      id: 8,
      nom: 'Bissara',
      niveauDifficulte: 'Facile',
      tempsPreparation: 40,
      compatibilite: 95,
      nbManquants: 0,
      imageUrl: 'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=600',
    ),
  ];

  /// Retourne la liste filtrée depuis les données mockées.
  /// Quand le backend sera prêt, remplacer le corps par un appel HTTP.
  Future<List<Recette>> fetchRecettes({
    String? search,
    String? difficulte,
  }) async {
    // Simule un délai réseau
    await Future.delayed(const Duration(milliseconds: 400));

    var result = List<Recette>.from(_mockRecettes);

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

    // Tri par compatibilité décroissante
    result.sort((a, b) => b.compatibilite.compareTo(a.compatibilite));

    return result;
  }
}