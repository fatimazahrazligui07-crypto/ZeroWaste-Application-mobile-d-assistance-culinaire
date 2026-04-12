import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/ingredient.dart';
import '../core/theme/colors.dart';

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
      child: Container(
        decoration: BoxDecoration(
          color: ingredient.selectionne ? ZWColors.orangeLight : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ingredient.selectionne ? ZWColors.orange : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ingredient.svgIcon != null)
              SvgPicture.string(
                ingredient.svgIcon!,
                width: 32,
                height: 32,
                colorFilter: ColorFilter.mode(
                  ingredient.couleur ?? ZWColors.taupe,
                  BlendMode.srcIn,
                ),
              )
            else
              Icon(
                Icons.restaurant_rounded,
                size: 32,
                color: ingredient.couleur ?? ZWColors.taupe,
              ),
            const SizedBox(height: 8),
            Text(
              ingredient.nom,
              style: TextStyle(
                fontSize: 13,
                fontWeight: ingredient.selectionne ? FontWeight.w700 : FontWeight.w500,
                color: ZWColors.brunFonce,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
