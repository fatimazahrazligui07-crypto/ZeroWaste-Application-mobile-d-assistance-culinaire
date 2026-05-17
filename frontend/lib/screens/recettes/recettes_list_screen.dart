// lib/screens/recettes/recettes_list_screen.dart
//
// MODIFICATIONS :
//   • Les arguments passés depuis AffinerRechercheScreen sont maintenant un
//     Map<String,dynamic> (et non plus une simple List<int>).
//   • On extrait ingredient_ids, nombre_personnes, intervalle_temps_id,
//     quantites_frigo depuis ce Map.
//   • On affiche un bandeau récapitulatif (personnes + intervalle) en mode
//     suggestion.
//   • L'appel API passe par fetchSuggestionsRaw() avec les nouveaux champs.

import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/recette.dart';
import '../../services/recette_service.dart';
import '../../services/ingredient_service.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/recipe_card.dart';
import 'recette_detail_screen.dart';

class RecettesListScreen extends StatefulWidget {
  const RecettesListScreen({super.key});

  @override
  State<RecettesListScreen> createState() => _RecettesListScreenState();
}

class _RecettesListScreenState extends State<RecettesListScreen> {
  final RecetteService _service = RecetteService();
  final TextEditingController _searchCtrl = TextEditingController();

  List<Recette> _recettes = [];
  bool _isLoading = true;
  bool _noMatch = false;
  String? _error;

  String? _selectedDifficulte;
  static const List<String> _niveaux = ['Tous', 'Facile', 'Moyen', 'Difficile'];

  // ── Données de suggestion ─────────────────────────────────────────────────
  bool _isSuggestionMode = false;
  List<int> _ingredientIds = [];
  int _nombrePersonnes = 2;
  int? _intervalleTempsId;
  Map<int, double> _quantitesFrigo = {};
  String _intervalleLibelle = 'Peu importe';

  // ── Init ──────────────────────────────────────────────────────────────────

  List<Map<String, dynamic>> _ingredientsPayload = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args is Map<String, dynamic>) {
        setState(() {
          _ingredientsPayload = List<Map<String, dynamic>>.from(args['ingredients'] ?? []);
          _nombrePersonnes  = (args['nombre_personnes'] as int?) ?? 2;
          _intervalleTempsId = args['intervalle_temps_id'] as int?;
          _intervalleLibelle = (args['intervalle_libelle'] as String?) ?? 'Peu importe';
          _isSuggestionMode = _ingredientsPayload.isNotEmpty;
        });
      } else if (args is List<int> && args.isNotEmpty) {
        // ── Ancien format (compatibilité) ─────────────────────────────────
        setState(() {
          _ingredientIds    = args;
          _isSuggestionMode = true;
        });
      }

      _load();
    });
  }

  /// Convertit la map brute  { int_id: double_valeur }  en Map<int, double>
  Map<int, double> _parseQuantitesFrigo(dynamic raw) {
    if (raw == null) return {};
    if (raw is Map) {
      return {
        for (final e in raw.entries)
          (e.key is int ? e.key as int : int.tryParse(e.key.toString()) ?? 0):
          (e.value is double ? e.value as double
              : (e.value as num).toDouble()),
      };
    }
    return {};
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── Chargement ────────────────────────────────────────────────────────────

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error     = null;
    });

    try {
      List<Recette> recettes = [];

      if (_isSuggestionMode && _ingredientsPayload.isNotEmpty) {
        final response = await IngredientService().fetchSuggestionsRaw(
          ingredients:      _ingredientsPayload,
          nombrePersonnes:  _nombrePersonnes,
          intervalleTempsId: _intervalleTempsId,
        );

        setState(() => _noMatch = response['no_match'] ?? false);
        recettes = (response['suggestions'] as List)
            .map((s) => Recette.fromJson(s))
            .toList();
      } else {
        recettes = await _service.fetchRecettes(
          search: _searchCtrl.text.trim().isEmpty
              ? null : _searchCtrl.text.trim(),
          difficulte: _selectedDifficulte,
        );
      }

      setState(() {
        _recettes  = recettes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error     = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String _) => _load();

  void _onDifficulteSelected(String niveau) {
    setState(() {
      _selectedDifficulte = niveau == 'Tous' ? null : niveau;
    });
    _load();
  }

  void _openDetail(Recette recette) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => RecetteDetailScreen(recetteId: recette.id)),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            // Bandeau récapitulatif visible uniquement en mode suggestion
            if (_isSuggestionMode) _buildSuggestionBanner(),
            _buildSearchBar(),
            _buildDifficulteFilter(),
            const SizedBox(height: 8),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 2),
    );
  }

  // ── Bandeau de contexte (nouveau) ─────────────────────────────────────────

  Widget _buildSuggestionBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: ZWColors.orangeLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZWColors.orange.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.tune_rounded,
              color: ZWColors.orange, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 8,
              children: [
                _BannerChip(
                  icon: Icons.people_alt_outlined,
                  label: '$_nombrePersonnes pers.',
                ),
                _BannerChip(
                  icon: Icons.access_time_rounded,
                  label: _intervalleLibelle,
                ),
                _BannerChip(
                  icon: Icons.kitchen_outlined,
                  label: '${_ingredientsPayload.length} ingr.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 4),
      child: Row(
        children: [
          const Text(
            'Recettes',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: ZWColors.brunFonce,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: _load,
            icon: const Icon(Icons.tune_rounded,
                color: ZWColors.orange, size: 26),
            tooltip: 'Filtres',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        controller: _searchCtrl,
        onChanged: _onSearchChanged,
        style: const TextStyle(fontSize: 14, color: ZWColors.brunFonce),
        decoration: InputDecoration(
          hintText: 'Rechercher une recette...',
          hintStyle:
              const TextStyle(color: ZWColors.taupe, fontSize: 14),
          prefixIcon: const Icon(Icons.search_rounded,
              color: ZWColors.taupe, size: 20),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: ZWColors.taupe, size: 18),
                  onPressed: () {
                    _searchCtrl.clear();
                    _load();
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: ZWColors.orange, width: 1.5)),
        ),
      ),
    );
  }

  Widget _buildDifficulteFilter() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _niveaux.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final niveau = _niveaux[index];
          final isSelected =
              (niveau == 'Tous' && _selectedDifficulte == null) ||
                  niveau == _selectedDifficulte;
          return GestureDetector(
            onTap: () => _onDifficulteSelected(niveau),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? ZWColors.orange : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: ZWColors.orange.withOpacity(0.30),
                            blurRadius: 8,
                            offset: const Offset(0, 3))
                      ]
                    : [],
              ),
              child: Text(
                niveau,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : ZWColors.taupe,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Corps ─────────────────────────────────────────────────────────────────

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: ZWColors.orange));
    }
    if (_error != null) return _buildError();
    if (_recettes.isEmpty) return _buildEmpty();

    return Column(
      children: [
        if (_noMatch)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ZWColors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: ZWColors.orange.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline,
                    color: ZWColors.orange, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Aucune recette exacte trouvée. Voici les recettes les plus proches !',
                    style: TextStyle(
                        color: ZWColors.orange, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: RefreshIndicator(
            color: ZWColors.orange,
            onRefresh: _load,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              itemCount: _recettes.length,
              itemBuilder: (context, index) => RecipeCard(
                recette: _recettes[index],
                onTap: () => _openDetail(_recettes[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: ZWColors.taupe),
            const SizedBox(height: 12),
            const Text(
              'Impossible de charger les recettes',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ZWColors.brunFonce),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: _load,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Réessayer'),
              style: TextButton.styleFrom(
                  foregroundColor: ZWColors.orange),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu_rounded,
                size: 56,
                color: ZWColors.taupe.withOpacity(0.4)),
            const SizedBox(height: 16),
            const Text(
              'Aucune recette trouvée',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ZWColors.brunFonce),
            ),
            const SizedBox(height: 6),
            const Text(
              'Essayez un autre filtre ou terme de recherche',
              style: TextStyle(fontSize: 13, color: ZWColors.taupe),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Widget puce de résumé dans le bandeau
// ═══════════════════════════════════════════════════════════════════════════

class _BannerChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BannerChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: ZWColors.orange),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ZWColors.brunFonce),
        ),
      ],
    );
  }
}