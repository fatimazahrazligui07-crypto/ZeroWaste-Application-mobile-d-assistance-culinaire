import 'package:flutter/material.dart';
import '../models/recette.dart';
import '../core/theme/colors.dart';

class RecipeCard extends StatelessWidget {
  final Recette recette;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: recette.imageUrl != null
                  ? Image.network(
                      recette.imageUrl!,
                      width: 100,
                      height: 100,
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
                    Text(
                      recette.nom,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: ZWColors.brunFonce,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 14, color: ZWColors.taupe),
                        const SizedBox(width: 4),
                        Text('${recette.tempsPreparation} min', style: const TextStyle(fontSize: 12, color: ZWColors.taupe)),
                        const SizedBox(width: 12),
                        const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: ZWColors.taupe),
                        const SizedBox(width: 4),
                        Text(recette.niveauDifficulte, style: const TextStyle(fontSize: 12, color: ZWColors.taupe)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Barre de compatibilité
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: recette.compatibilite / 100,
                              minHeight: 6,
                              backgroundColor: const Color(0xFFEEEEEE),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                recette.compatibilite >= 90 ? const Color(0xFF4CAF50) : ZWColors.orange,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${recette.compatibilite}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ZWColors.taupe,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
        width: 100,
        height: 100,
        color: ZWColors.orangeLight,
        child: const Icon(Icons.restaurant_rounded, color: ZWColors.orange, size: 36),
      );
}
