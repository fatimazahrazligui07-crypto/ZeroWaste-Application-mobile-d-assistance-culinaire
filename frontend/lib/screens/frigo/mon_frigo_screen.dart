// lib/screens/frigo/mon_frigo_screen.dart
//
// MODIFICATION : le FloatingActionButton ne navigue plus directement vers
// '/recettes'.  Il ouvre d'abord AffinerRechercheScreen pour que l'utilisateur
// renseigne les contraintes (quantités, temps, nb personnes).

import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/categorie.dart';
import '../../models/ingredient.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/ingredient_card.dart';
import '../../services/ingredient_service.dart';
import 'affiner_recherche_screen.dart'; // ← nouveau import

class MonFrigoScreen extends StatefulWidget {
  const MonFrigoScreen({super.key});

  @override
  State<MonFrigoScreen> createState() => _MonFrigoScreenState();
}

class _MonFrigoScreenState extends State<MonFrigoScreen> {
  final IngredientService _ingredientService = IngredientService();

  String _searchQuery = '';
  String _selectedCategoryId = 'tout';

  List<Categorie> _categories = [
    const Categorie(id: 'tout', label: 'Tout', svgIcon: ''),
  ];
  List<Ingredient> _ingredients = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final results = await Future.wait([
        _ingredientService.fetchCategories(),
        _ingredientService.fetchIngredients(),
      ]);

      setState(() {
        _categories = [
          const Categorie(id: 'tout', label: 'Tout', svgIcon: ''),
          ...results[0] as List<Categorie>,
        ];
        _ingredients = results[1] as List<Ingredient>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error =
            "Impossible de charger les données. Vérifiez que le backend est lancé.";
      });
    }
  }

  // ── Navigation vers AffinerRechercheScreen ────────────────────────────────

  void _onTrouverRecettes() {
    final selectedIngredients =
        _ingredients.where((ing) => ing.selectionne).toList();

    if (selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sélectionnez au moins 1 ingrédient !'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // On pousse l'écran de contraintes sur le stack de navigation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AffinerRechercheScreen(
          selectedIngredients: selectedIngredients,
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final filteredIngredients = _ingredients.where((ing) {
      final matchesSearch =
          ing.nom.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategoryId == 'tout' ||
          ing.categorieId == _selectedCategoryId;
      return matchesSearch && matchesCategory;
    }).toList();

    // Nombre d'ingrédients sélectionnés (pour le badge du FAB)
    final nbSelected =
        _ingredients.where((i) => i.selectionne).length;

    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _searchBar(),
            _categoryTabs(),
            Expanded(
              child: _buildContent(filteredIngredients),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onTrouverRecettes,
        backgroundColor: ZWColors.orange,
        icon: const Icon(Icons.tune_rounded, color: Colors.white),
        label: Row(
          children: [
            const Text(
              'Affiner & trouver',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
            if (nbSelected > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$nbSelected',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ── Widgets internes (inchangés) ──────────────────────────────────────────

  Widget _buildContent(List<Ingredient> filteredIngredients) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: ZWColors.orange));
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: ZWColors.taupe)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _loadData,
              style: ElevatedButton.styleFrom(
                  backgroundColor: ZWColors.orange),
              child: const Text('Réessayer',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    if (filteredIngredients.isEmpty) {
      return const Center(
        child: Text('Aucun ingrédient trouvé',
            style: TextStyle(color: ZWColors.taupe)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: filteredIngredients.length,
      itemBuilder: (context, index) {
        final ingredient = filteredIngredients[index];
        return IngredientCard(
          ingredient: ingredient,
          onTap: () {
            setState(() {
              ingredient.selectionne = !ingredient.selectionne;
            });
          },
        );
      },
    );
  }

  Widget _header() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mon Frigo',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: ZWColors.brunFonce)),
                Text('Sélectionnez vos ingrédients',
                    style:
                        TextStyle(fontSize: 14, color: ZWColors.taupe)),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh, color: ZWColors.orange),
            ),
          ],
        ),
      );

  Widget _searchBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: TextField(
          onChanged: (val) => setState(() => _searchQuery = val),
          decoration: InputDecoration(
            hintText: 'Rechercher un ingrédient...',
            prefixIcon:
                const Icon(Icons.search, color: ZWColors.taupe),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );

  Widget _categoryTabs() => SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final cat = _categories[index];
            final isSelected = _selectedCategoryId == cat.id;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                label: Text(cat.label),
                selected: isSelected,
                onSelected: (val) =>
                    setState(() => _selectedCategoryId = cat.id),
                selectedColor: ZWColors.orange,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : ZWColors.taupe,
                  fontWeight: isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            );
          },
        ),
      );
}