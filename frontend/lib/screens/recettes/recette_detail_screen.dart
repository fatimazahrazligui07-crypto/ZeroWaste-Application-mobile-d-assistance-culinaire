// lib/screens/recettes/recette_detail_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/recette.dart';
import '../../services/recette_service.dart';
import '../../widgets/bottom_nav_bar.dart';

class RecetteDetailScreen extends StatefulWidget {
  final int recetteId;
  const RecetteDetailScreen({super.key, required this.recetteId});

  @override
  State<RecetteDetailScreen> createState() => _RecetteDetailScreenState();
}

class _RecetteDetailScreenState extends State<RecetteDetailScreen> {
  final _service = RecetteService();
  RecetteDetail? _detail;
  bool _isLoading = true;
  String? _error;

  // Onglet actif : 0 = Ingrédients, 1 = Préparation
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final d = await _service.fetchDetail(widget.recetteId);
      setState(() { _detail = d; _isLoading = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: ZWColors.fondPrincipal,
        body: Center(child: CircularProgressIndicator(color: ZWColors.orange)),
      );
    }
    if (_error != null || _detail == null) {
      return Scaffold(
        backgroundColor: ZWColors.fondPrincipal,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 48, color: ZWColors.taupe),
              const SizedBox(height: 12),
              const Text('Impossible de charger la recette'),
              TextButton(onPressed: _load, child: const Text('Réessayer')),
            ],
          ),
        ),
      );
    }

    final d = _detail!;
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 2),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(d),
          SliverToBoxAdapter(child: _buildBody(d)),
        ],
      ),
      bottomSheet: _tab == 1 ? _buildStepButton(d) : null,
    );
  }

  // ── AppBar avec image ───────────────────────────────────────────────────────

  Widget _buildAppBar(RecetteDetail d) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: ZWColors.fondPrincipal,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
          ),
          child: const Icon(Icons.arrow_back_rounded, color: ZWColors.brunFonce, size: 20),
        ),
      ),
      actions: [
        _circleButton(Icons.favorite_border_rounded),
        const SizedBox(width: 4),
        _circleButton(Icons.share_rounded),
        const SizedBox(width: 10),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: d.imageUrl != null
            ? Image.network(
          d.imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _imgPlaceholder(),
        )
            : _imgPlaceholder(),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6)],
      ),
      child: Icon(icon, color: ZWColors.brunFonce, size: 18),
    );
  }

  Widget _imgPlaceholder() => Container(
    color: ZWColors.orangeLight,
    child: const Center(
      child: Icon(Icons.restaurant_rounded, color: ZWColors.orange, size: 60),
    ),
  );

  // ── Corps principal ─────────────────────────────────────────────────────────

  Widget _buildBody(RecetteDetail d) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Text(
            d.nom,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: ZWColors.brunFonce,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),

          // Méta : temps · difficulté · personnes
          _buildMeta(d),
          const SizedBox(height: 16),

          // Carte infos nutritionnelles (placeholder)
          _buildNutritionCard(),
          const SizedBox(height: 24),

          // Onglets Ingrédients / Préparation
          _buildTabs(),
          const SizedBox(height: 16),

          // Contenu de l'onglet
          _tab == 0 ? _buildIngredients(d) : _buildPreparation(d),
        ],
      ),
    );
  }

  // ── Méta ────────────────────────────────────────────────────────────────────

  Widget _buildMeta(RecetteDetail d) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded, size: 15, color: ZWColors.orange),
        const SizedBox(width: 4),
        Text('${d.tempsTotal} min',
            style: const TextStyle(fontSize: 13, color: ZWColors.taupe)),
        const SizedBox(width: 14),
        const Icon(Icons.bar_chart_rounded, size: 15, color: ZWColors.taupe),
        const SizedBox(width: 4),
        Text(d.niveauDifficulte,
            style: const TextStyle(fontSize: 13, color: ZWColors.taupe)),
        const SizedBox(width: 14),
        const Icon(Icons.people_alt_outlined, size: 15, color: ZWColors.taupe),
        const SizedBox(width: 4),
        Text('${d.nbPersonnes} personnes',
            style: const TextStyle(fontSize: 13, color: ZWColors.taupe)),
      ],
    );
  }

  // ── Carte nutrition ─────────────────────────────────────────────────────────

  Widget _buildNutritionCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: ZWColors.vertBasilic.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: ZWColors.vertBasilic.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: ZWColors.vertBasilic.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info_outline_rounded,
                color: ZWColors.vertBasilic, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Informations nutritionnelles',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: ZWColors.brunFonce)),
                const SizedBox(height: 2),
                Text('450 cal • 35g • 25g • 20g',
                    style: TextStyle(
                        fontSize: 11,
                        color: ZWColors.taupe.withOpacity(0.8))),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: ZWColors.vertBasilic),
        ],
      ),
    );
  }

  // ── Onglets ─────────────────────────────────────────────────────────────────

  Widget _buildTabs() {
    return Row(
      children: [
        _tabChip('Ingrédients', 0),
        const SizedBox(width: 10),
        _tabChip('Préparation', 1),
      ],
    );
  }

  Widget _tabChip(String label, int index) {
    final active = _tab == index;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: active ? ZWColors.orange : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: active
              ? [BoxShadow(
              color: ZWColors.orange.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : ZWColors.taupe,
          ),
        ),
      ),
    );
  }

  // ── Onglet Ingrédients ──────────────────────────────────────────────────────

  Widget _buildIngredients(RecetteDetail d) {
    return Column(
      children: d.ingredients
          .map((ing) => _IngredientRow(ingredient: ing))
          .toList(),
    );
  }

  // ── Onglet Préparation ──────────────────────────────────────────────────────

  Widget _buildPreparation(RecetteDetail d) {
    return Column(
      children: d.instructions
          .asMap()
          .entries
          .map((entry) => _StepRow(
        index: entry.key,
        text: entry.value,
        isFirst: entry.key == 0,
      ))
          .toList(),
    );
  }

  // ── Bouton "Étape suivante" (visible onglet préparation) ────────────────────

  Widget _buildStepButton(RecetteDetail d) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
      color: ZWColors.fondPrincipal,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: ZWColors.orange,
            foregroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: const Text(
            'Étape suivante',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

// ─── Widget ligne ingrédient ──────────────────────────────────────────────────

class _IngredientRow extends StatelessWidget {
  final IngredientLigne ingredient;
  const _IngredientRow({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icône disponibilité
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ingredient.disponible
                  ? ZWColors.vertBasilic.withOpacity(0.12)
                  : ZWColors.orange.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ingredient.disponible
                  ? Icons.check_rounded
                  : Icons.close_rounded,
              size: 16,
              color: ingredient.disponible ? ZWColors.vertBasilic : ZWColors.orange,
            ),
          ),
          const SizedBox(width: 12),
          // Nom
          Expanded(
            child: Text(
              ingredient.nom,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ingredient.disponible
                    ? ZWColors.brunFonce
                    : ZWColors.brunFonce.withOpacity(0.6),
              ),
            ),
          ),
          // Quantité
          Text(
            ingredient.quantite,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ZWColors.taupe,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Widget étape préparation ─────────────────────────────────────────────────

class _StepRow extends StatelessWidget {
  final int index;
  final String text;
  final bool isFirst;
  const _StepRow({required this.index, required this.text, required this.isFirst});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isFirst ? Colors.white : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isFirst
            ? Border.all(color: ZWColors.orange.withOpacity(0.5), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Numéro
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isFirst ? ZWColors.orange : ZWColors.beigeInput,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isFirst ? Colors.white : ZWColors.taupe,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Texte
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: ZWColors.brunFonce,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}