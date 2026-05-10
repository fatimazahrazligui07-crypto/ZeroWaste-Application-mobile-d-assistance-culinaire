import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../models/recette.dart';

class NutritionScreen extends StatelessWidget {
  final Recette? recette;

  const NutritionScreen({super.key, this.recette});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCaloriesCard(),
                  const SizedBox(height: 20),
                  _buildMacronutriments(),
                  const SizedBox(height: 20),
                  _buildVitamines(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          recette?.imageUrl != null
              ? Image.network(
                  recette!.imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    color: ZWColors.orange.withOpacity(0.2),
                    child: const Icon(Icons.restaurant, size: 60, color: ZWColors.orange),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: ZWColors.orange.withOpacity(0.2),
                  child: const Icon(Icons.restaurant, size: 60, color: ZWColors.orange),
                ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back_ios_new, size: 18, color: ZWColors.brunFonce),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recette?.nom ?? 'Informations nutritionnelles',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${recette?.tempsPreparation ?? 0} min  •  ${recette?.niveauDifficulte ?? ''}',
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesCard() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ZWColors.orange.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: ZWColors.orange.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.local_fire_department, color: ZWColors.orange, size: 26),
                ),
                const SizedBox(height: 8),
                const Text('450', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
                const Text('Calories', style: TextStyle(fontSize: 13, color: ZWColors.taupe)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF3E7D52).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(color: Color(0xFFEAF5EE), shape: BoxShape.circle),
                  child: const Icon(Icons.favorite_outline, color: Color(0xFF3E7D52), size: 26),
                ),
                const SizedBox(height: 8),
                const Text('Équilibré', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
                const Text('Type', style: TextStyle(fontSize: 13, color: ZWColors.taupe)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMacronutriments() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Macronutriments',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
          const SizedBox(height: 16),
          _macroRow(icon: Icons.egg_outlined, label: 'Protéines', valeur: '35g', progression: 0.7, couleur: ZWColors.orange),
          const SizedBox(height: 14),
          _macroRow(icon: Icons.grain, label: 'Glucides', valeur: '25g', progression: 0.5, couleur: const Color(0xFFFFB300)),
          const SizedBox(height: 14),
          _macroRow(icon: Icons.water_drop_outlined, label: 'Lipides', valeur: '20g', progression: 0.4, couleur: const Color(0xFF3E7D52)),
        ],
      ),
    );
  }

  Widget _macroRow({required IconData icon, required String label, required String valeur, required double progression, required Color couleur}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: couleur),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 14, color: ZWColors.brunFonce, fontWeight: FontWeight.w500))),
            Text(valeur, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: couleur)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progression,
            minHeight: 6,
            backgroundColor: couleur.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(couleur),
          ),
        ),
      ],
    );
  }

  Widget _buildVitamines() {
    final vitamines = [
      {'label': 'Vitamine C', 'valeur': '45mg'},
      {'label': 'Vitamine B6', 'valeur': '0.8mg'},
      {'label': 'Fer', 'valeur': '3.2mg'},
      {'label': 'Calcium', 'valeur': '52mg'},
      {'label': 'Magnésium', 'valeur': '38mg'},
      {'label': 'Zinc', 'valeur': '2.1mg'},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Vitamines & Minéraux',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: vitamines.map((v) => _vitaminePill(v['label']!, v['valeur']!)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _vitaminePill(String label, String valeur) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF5F0EB), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: ZWColors.taupe)),
          const SizedBox(height: 2),
          Text(valeur, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: ZWColors.brunFonce)),
        ],
      ),
    );
  }
}