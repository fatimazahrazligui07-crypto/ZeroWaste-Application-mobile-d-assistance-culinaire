import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/recette.dart';
import '../../widgets/bottom_nav_bar.dart';

class RecetteDetailScreen extends StatefulWidget {
  final Recette recette;
  const RecetteDetailScreen({super.key, required this.recette});

  @override
  State<RecetteDetailScreen> createState() => _RecetteDetailScreenState();
}

class _RecetteDetailScreenState extends State<RecetteDetailScreen> {
  bool _isFavori = false;
  int _currentStep = 0;

  final List<Map<String, String>> _ingredientsDisponibles = [
    {'nom': 'Poulet coupé', 'quantite': '500g'},
    {'nom': 'Citrons confits', 'quantite': '2'},
    {'nom': 'Oignons', 'quantite': '2'},
    {'nom': 'Cumin', 'quantite': '1 c.à.c'},
    {'nom': 'Paprika', 'quantite': '1 c.à.c'},
    {'nom': 'Coriandre fraîche', 'quantite': '1 bouquet'},
  ];

  final List<Map<String, String>> _ingredientsManquants = [
    {'nom': 'Olives vertes', 'quantite': '100g'},
  ];

  final List<String> _etapes = [
    "Faire revenir le poulet avec les oignons émincés dans une cocotte avec un peu d'huile d'olive.",
    "Ajouter le cumin, le paprika, sel et poivre. Bien mélanger.",
    "Ajouter les citrons confits coupés en quartiers et les olives.",
    "Verser un verre d'eau, couvrir et laisser mijoter 35-40 minutes à feu doux.",
    "Parsemer de coriandre fraîche ciselée avant de servir.",
    "Accompagner de pain marocain ou de semoule.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoGenerales(),
                      const SizedBox(height: 16),
                      _buildNutritionButton(context),
                      const SizedBox(height: 24),
                      _buildIngredients(),
                      const SizedBox(height: 24),
                      _buildEtapes(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomButton(),
          ),
        ],
      ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 2),
    );
  }

  // ─── Header ───────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 288,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.recette.imageUrl != null
              ? Image.network(
                  widget.recette.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFFF4E1F).withOpacity(0.2),
                    child: const Icon(Icons.restaurant, size: 80, color: Color(0xFFFF4E1F)),
                  ),
                )
              : Container(
                  color: const Color(0xFFFF4E1F).withOpacity(0.2),
                  child: const Icon(Icons.restaurant, size: 80, color: Color(0xFFFF4E1F)),
                ),
          // Dégradé bas
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                ),
              ),
            ),
          ),
          // Bouton retour
          Positioned(
            top: 48, left: 16,
            child: _circleBtn(Icons.arrow_back_ios_new, null, () => Navigator.pop(context)),
          ),
          // Favoris + partage
          Positioned(
            top: 48, right: 16,
            child: Row(
              children: [
                _circleBtn(
                  _isFavori ? Icons.favorite : Icons.favorite_border,
                  _isFavori ? Colors.red : null,
                  () => setState(() => _isFavori = !_isFavori),
                ),
                const SizedBox(width: 8),
                _circleBtn(Icons.share_outlined, null, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, Color? color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Icon(icon, size: 20, color: color ?? const Color(0xFF3E2723)),
      ),
    );
  }

  // ─── Infos générales ──────────────────────────────────────────────────────
  Widget _buildInfoGenerales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recette.nom,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF3E2723)),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _chip(Icons.access_time, '${widget.recette.tempsPreparation} min'),
            const SizedBox(width: 16),
            _chip(Icons.restaurant_menu, widget.recette.niveauDifficulte),
            const SizedBox(width: 16),
            _chip(Icons.people_outline, '4 personnes'),
          ],
        ),
      ],
    );
  }

  Widget _chip(IconData icon, String label) => Row(
    children: [
      Icon(icon, size: 16, color: const Color(0xFFFF4E1F)),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF8D7B6B), fontWeight: FontWeight.w500)),
    ],
  );

  // ─── Nutrition ────────────────────────────────────────────────────────────
  Widget _buildNutritionButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/recettes/nutrition', arguments: widget.recette),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3E7D52).withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF3E7D52).withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: Color(0xFF3E7D52), shape: BoxShape.circle),
              child: const Icon(Icons.info_outline, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informations nutritionnelles',
                      style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF3E7D52), fontSize: 14)),
                  SizedBox(height: 2),
                  Text('450 cal  •  35g  •  25g  •  20g',
                      style: TextStyle(fontSize: 12, color: Color(0xFF8D7B6B))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF3E7D52)),
          ],
        ),
      ),
    );
  }

  // ─── Ingrédients ──────────────────────────────────────────────────────────
  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ingrédients',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF3E2723))),
        const SizedBox(height: 12),
        ..._ingredientsDisponibles.map((i) => _ingRow(i, true)),
        const SizedBox(height: 8),
        ..._ingredientsManquants.map((i) => _ingRow(i, false)),
      ],
    );
  }

  Widget _ingRow(Map<String, String> ing, bool dispo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: dispo
              ? const Color(0xFF3E7D52).withOpacity(0.4)
              : const Color(0xFFFF4E1F).withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            dispo ? Icons.check_circle : Icons.cancel,
            size: 20,
            color: dispo ? const Color(0xFF3E7D52) : const Color(0xFFFF4E1F),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(ing['nom']!,
                style: const TextStyle(fontSize: 14, color: Color(0xFF3E2723), fontWeight: FontWeight.w500)),
          ),
          Text(ing['quantite']!, style: const TextStyle(fontSize: 13, color: Color(0xFF8D7B6B))),
        ],
      ),
    );
  }

  // ─── Étapes ───────────────────────────────────────────────────────────────
  Widget _buildEtapes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Préparation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF3E2723))),
        const SizedBox(height: 12),
        ...List.generate(_etapes.length, _etapeCard),
      ],
    );
  }

  Widget _etapeCard(int i) {
    final done = i < _currentStep;
    final active = i == _currentStep;

    final circleBg = done
        ? const Color(0xFF3E7D52)
        : active
            ? const Color(0xFFFF4E1F)
            : const Color(0xFFF5F0EB);

    final child = done
        ? const Icon(Icons.check, color: Colors.white, size: 16)
        : Text('${i + 1}',
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFF8D7B6B),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active ? const Color(0xFFFF4E1F) : Colors.transparent,
          width: active ? 1.5 : 0,
        ),
        boxShadow: active
            ? [BoxShadow(color: const Color(0xFFFF4E1F).withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4))]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: circleBg, shape: BoxShape.circle),
            child: Center(child: child),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _etapes[i],
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: active ? const Color(0xFF3E2723) : const Color(0xFF8D7B6B),
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bouton bas ───────────────────────────────────────────────────────────
  Widget _buildBottomButton() {
    final last = _currentStep >= _etapes.length - 1;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      color: const Color(0xFFF5F0EB),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (last) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🎉 Recette terminée ! Bon appétit !')),
              );
            } else {
              setState(() => _currentStep++);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4E1F),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Text(
            last ? 'Terminer la recette' : 'Étape suivante',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}