import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/recette.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/recipe_card.dart';

class RecettesScreen extends StatefulWidget {
  const RecettesScreen({super.key});

  @override
  State<RecettesScreen> createState() => _RecettesScreenState();
}

class _RecettesScreenState extends State<RecettesScreen> {
  String _searchQuery = '';
  
  // Données factices pour l'exemple
  final List<Recette> _recettes = [
    Recette(id: 1, nom: 'Couscous Royal', niveauDifficulte: 'Moyen', tempsPreparation: 120, compatibilite: 95),
    Recette(id: 2, nom: 'Tajine de Poulet', niveauDifficulte: 'Facile', tempsPreparation: 45, compatibilite: 80),
    Recette(id: 3, nom: 'Harira Marocaine', niveauDifficulte: 'Moyen', tempsPreparation: 60, compatibilite: 60),
    Recette(id: 4, nom: 'Salade de Tomates', niveauDifficulte: 'Très Facile', tempsPreparation: 10, compatibilite: 100),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredRecettes = _recettes.where((r) {
      return r.nom.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _searchBar(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                itemCount: filteredRecettes.length,
                itemBuilder: (context, index) {
                  return RecipeCard(
                    recette: filteredRecettes[index],
                    onTap: () {
                      // Action au clic sur une recette
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 2),
    );
  }

  Widget _header() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recettes',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
                Text('Découvrez de nouveaux plats',
                    style: TextStyle(fontSize: 14, color: ZWColors.taupe)),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border, color: ZWColors.orange),
            ),
          ],
        ),
      );

  Widget _searchBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: TextField(
          onChanged: (val) => setState(() => _searchQuery = val),
          decoration: InputDecoration(
            hintText: 'Rechercher une recette...',
            prefixIcon: const Icon(Icons.search, color: ZWColors.taupe),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
}
