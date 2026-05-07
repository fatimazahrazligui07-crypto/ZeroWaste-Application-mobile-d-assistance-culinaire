// lib/widgets/recipe_card.dart
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

  Color get _compatColor {
    if (recette.compatibilite >= 90) return const Color(0xFF4CAF50);
    if (recette.compatibilite >= 60) return ZWColors.safran;
    return ZWColors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image + badges ────────────────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: recette.imageUrl != null
                        ? Image.network(
                      recette.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                      loadingBuilder: (_, child, progress) =>
                      progress == null ? child : _shimmer(),
                    )
                        : _placeholder(),
                  ),
                ),

                // Badge "X manquants" — coin supérieur gauche
                if (recette.nbManquants > 0)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _Badge(
                      color: ZWColors.orange,
                      child: Text(
                        '${recette.nbManquants} manquant${recette.nbManquants > 1 ? 's' : ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                // Badge compatibilité — coin supérieur droit
                Positioned(
                  top: 10,
                  right: 10,
                  child: _Badge(
                    color: Colors.black.withOpacity(0.55),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: _compatColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${recette.compatibilite}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ── Infos ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom
                  Text(
                    recette.nom,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ZWColors.brunFonce,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Temps + Difficulté
                  Row(
                    children: [
                      const Icon(Icons.access_time_rounded,
                          size: 14, color: ZWColors.orange),
                      const SizedBox(width: 4),
                      Text(
                        '${recette.tempsPreparation} min',
                        style: const TextStyle(
                            fontSize: 12, color: ZWColors.taupe),
                      ),
                      const SizedBox(width: 14),
                      const Icon(Icons.signal_cellular_alt_rounded,
                          size: 14, color: ZWColors.taupe),
                      const SizedBox(width: 4),
                      Text(
                        recette.niveauDifficulte,
                        style: const TextStyle(
                            fontSize: 12, color: ZWColors.taupe),
                      ),
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
                                _compatColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${recette.compatibilite}%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _compatColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => Container(
    color: ZWColors.orangeLight,
    child: const Center(
      child: Icon(Icons.restaurant_rounded,
          color: ZWColors.orange, size: 44),
    ),
  );

  Widget _shimmer() => Container(color: ZWColors.beigeInput);
}

// ─── Badge réutilisable ───────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final Color color;
  final Widget child;
  const _Badge({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}