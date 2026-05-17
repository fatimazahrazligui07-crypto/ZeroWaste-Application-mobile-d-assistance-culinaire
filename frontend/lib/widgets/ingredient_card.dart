import 'package:flutter/material.dart';
import '../models/ingredient.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback onTap;

  const IngredientCard({
    super.key,
    required this.ingredient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: ingredient.selectionne
              ? (ingredient.couleur?.withOpacity(0.15) ?? Colors.orange.withOpacity(0.15))
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ingredient.selectionne
                ? (ingredient.couleur ?? Colors.orange)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: 8),
            Text(
              ingredient.nom,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: ingredient.selectionne
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: const Color(0xFF3E2723),
              ),
            ),
            if (ingredient.selectionne)
              const Icon(Icons.check_circle, color: Colors.orange, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final icon = ingredient.svgIcon;

    if (icon != null && icon.startsWith('http')) {
      return Image.network(
        icon,
        width: 48,
        height: 48,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(
          Icons.fastfood,
          size: 40,
          color: ingredient.couleur ?? Colors.grey,
        ),
      );
    }

    return CircleAvatar(
      backgroundColor: ingredient.couleur ?? Colors.grey.shade300,
      radius: 24,
      child: Text(
        ingredient.nom[0].toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}