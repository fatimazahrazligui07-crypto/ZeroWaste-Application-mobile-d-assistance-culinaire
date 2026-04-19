// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../services/home_service.dart';
import '../../models/home_stats.dart';
import '../../models/recette.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeService _service = HomeService();
  HomeStats? _stats;
  List<Recette> _recettes = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = await _service.fetchHome();
      setState(() {
        _stats    = data['stats'];
        _recettes = data['recettes'];
        _loading  = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: ZWColors.orange))
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _heroHeader()),
                SliverToBoxAdapter(child: _sectionTitle()),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => _recetteCard(_recettes[i]),
                    childCount: _recettes.length,
                  ),
                ),
                SliverToBoxAdapter(child: _voirToutesBtn()),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 0),
    );
  }

  // ── Hero avec Dégradé Orange -> Safran ──────────────────────────────────────
  Widget _heroHeader() => Container(
        padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ZWColors.orange, ZWColors.safran],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salutation
            Row(children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_outline_rounded,
                    color: Colors.white, size: 22),
              ),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Bonjour,',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
                const Text('Bienvenue chef!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ]),
            ]),
            const SizedBox(height: 20),
            // Stats cards (Seulement Ingrédients et Recettes)
            Row(children: [
              _statCard(
                icon: Icons.kitchen_outlined,
                label: 'Ingrédients',
                value: '${_stats?.nbIngredients ?? 0}',
              ),
              const SizedBox(width: 12),
              _statCard(
                icon: Icons.menu_book_outlined,
                label: 'Recettes',
                value: '${_stats?.nbRecettes ?? 0}',
              ),
            ]),
          ],
        ),
      );

  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
  }) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: Colors.white70, size: 18),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(color: Colors.white70, fontSize: 11)),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      );

  // ── Section titre ──────────────────────────────────────────────────────────
  Widget _sectionTitle() => const Padding(
        padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
        child: Row(children: [
          Text('✨ ', style: TextStyle(fontSize: 16)),
          Text('Recettes suggérées',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ZWColors.brunFonce)),
        ]),
      );

  // ── Carte recette ──────────────────────────────────────────────────────────
  Widget _recetteCard(Recette recette) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            child: recette.imageUrl != null
                ? Image.network(
                    recette.imageUrl!,
                    width: 90, height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
          // Infos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recette.nom,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ZWColors.brunFonce)),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.access_time_rounded,
                        size: 12, color: ZWColors.taupe),
                    const SizedBox(width: 3),
                    Text('${recette.tempsPreparation} min',
                        style: const TextStyle(
                            fontSize: 11, color: ZWColors.taupe)),
                    const SizedBox(width: 10),
                    const Icon(Icons.signal_cellular_alt_rounded,
                        size: 12, color: ZWColors.taupe),
                    const SizedBox(width: 3),
                    Text(recette.niveauDifficulte,
                        style: const TextStyle(
                            fontSize: 11, color: ZWColors.taupe)),
                  ]),
                  const SizedBox(height: 8),
                  // Barre de compatibilité
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: recette.compatibilite / 100,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFEEEEEE),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        recette.compatibilite >= 90
                            ? const Color(0xFF4CAF50)
                            : ZWColors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${recette.compatibilite}% de compatibilité',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ZWColors.taupe)),
                ],
              ),
            ),
          ),
        ]),
      );

  Widget _imagePlaceholder() => Container(
        width: 90, height: 90,
        color: ZWColors.orangeLight,
        child: const Icon(Icons.restaurant_rounded,
            color: ZWColors.orange, size: 32),
      );

  // ── Bouton voir toutes ─────────────────────────────────────────────────────
  Widget _voirToutesBtn() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/recettes'),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: ZWColors.orange,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: ZWColors.orange.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text('Voir toutes les recettes',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      );
}
