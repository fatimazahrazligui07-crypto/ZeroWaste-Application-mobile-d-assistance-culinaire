// lib/screens/frigo/affiner_recherche_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/colors.dart';
import '../../models/ingredient.dart';
import '../../models/intervalle_temps.dart';
import '../../services/ingredient_service.dart';

class AffinerRechercheScreen extends StatefulWidget {
  final List<Ingredient> selectedIngredients;

  const AffinerRechercheScreen({
    super.key,
    required this.selectedIngredients,
  });

  @override
  State<AffinerRechercheScreen> createState() => _AffinerRechercheScreenState();
}

class _AffinerRechercheScreenState extends State<AffinerRechercheScreen> {
  // Contrôleurs pour les quantités
  late Map<String, TextEditingController> _qtyControllers;
  // Unités sélectionnées par ingrédient
  final Map<String, String> _selectedUnits = {};

  // Filtres globaux
  int _nbPersonnes = 2;
  IntervalleTemps? _selectedIntervalle;

  // Données API
  List<IntervalleTemps> _intervalles = [];
  bool _loadingIntervalles = true;

  // Listes d'unités par type (simplifié pour l'exemple, on pourrait mapper par ingrédient)
  final List<String> _unitesMasse = ['g', 'kg'];
  final List<String> _unitesVolume = ['ml', 'cl', 'l'];
  final List<String> _unitesPiece = ['pièces'];

  @override
  void initState() {
    super.initState();
    _qtyControllers = {
      for (final ing in widget.selectedIngredients)
        ing.id: TextEditingController(),
    };
    // Initialiser les unités par défaut
    for (final ing in widget.selectedIngredients) {
      _selectedUnits[ing.id] = 'g'; // Défaut
    }
    _loadIntervalles();
  }

  @override
  void dispose() {
    for (final ctrl in _qtyControllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Future<void> _loadIntervalles() async {
    try {
      final data = await IngredientService().fetchIntervalles();
      setState(() {
        _intervalles = data;
        _loadingIntervalles = false;
      });
    } catch (_) {
      setState(() => _loadingIntervalles = false);
    }
  }

  void _onSubmit() {
    final List<Map<String, dynamic>> ingredientsPayload = [];
    
    for (final ing in widget.selectedIngredients) {
      final raw = _qtyControllers[ing.id]!.text.trim();
      final Map<String, dynamic> item = {'id': int.parse(ing.id)};
      
      if (raw.isNotEmpty) {
        item['quantite'] = double.tryParse(raw.replaceAll(',', '.')) ?? 0.0;
        item['unite'] = _selectedUnits[ing.id];
      }
      ingredientsPayload.add(item);
    }

    final args = <String, dynamic>{
      'ingredients': ingredientsPayload,
      'nombre_personnes': _nbPersonnes,
      'intervalle_temps_id': _selectedIntervalle?.id,
      'intervalle_libelle': _selectedIntervalle?.libelle ?? 'Peu importe',
    };

    Navigator.pushReplacementNamed(context, '/recettes', arguments: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuantitesSection(),
                    const SizedBox(height: 12),
                    _buildTempsSection(),
                    const SizedBox(height: 12),
                    _buildPersonnesSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ZWColors.orange, ZWColors.safran],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Affiner ma recherche',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Personnalisez vos suggestions',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitesSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.kitchen_outlined, color: ZWColors.orange, size: 20),
              SizedBox(width: 10),
              Text(
                'Vos quantités',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ZWColors.brunFonce),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...widget.selectedIngredients.map((ing) => _IngredientQtyRow(
                ingredient: ing,
                controller: _qtyControllers[ing.id]!,
                selectedUnit: _selectedUnits[ing.id]!,
                onUnitChanged: (val) {
                  setState(() => _selectedUnits[ing.id] = val!);
                },
                availableUnits: _getUnitsForIngredient(ing),
              )),
        ],
      ),
    );
  }

  List<String> _getUnitsForIngredient(Ingredient ing) {
    // Logique simplifiée : on pourrait baser cela sur la catégorie de l'ingrédient
    if (ing.nom.toLowerCase().contains('poulet') || ing.nom.toLowerCase().contains('viande')) {
      return ['g', 'kg', 'pièces'];
    } else if (ing.nom.toLowerCase().contains('lait') || ing.nom.toLowerCase().contains('eau')) {
      return ['ml', 'cl', 'l'];
    }
    return ['g', 'kg', 'pièces'];
  }

  Widget _buildTempsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.access_time_rounded, color: ZWColors.orange, size: 20),
              SizedBox(width: 10),
              Text('Temps maximum',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: ZWColors.brunFonce)),
            ],
          ),
          const SizedBox(height: 16),
          if (_loadingIntervalles)
            const Center(child: CircularProgressIndicator())
          else
            ...[
              _TempsOption(
                label: 'Peu importe',
                isSelected: _selectedIntervalle == null,
                onTap: () => setState(() => _selectedIntervalle = null),
              ),
              ..._intervalles.map((intv) => _TempsOption(
                    label: intv.libelle,
                    isSelected: _selectedIntervalle?.id == intv.id,
                    onTap: () => setState(() => _selectedIntervalle = intv),
                  )),
            ],
        ],
      ),
    );
  }

  Widget _buildPersonnesSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.people_alt_outlined, color: ZWColors.orange, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('Nombre de personnes',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: ZWColors.brunFonce)),
          ),
          _StepperButton(
            icon: Icons.remove,
            onTap: () {
              if (_nbPersonnes > 1) setState(() => _nbPersonnes--);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('$_nbPersonnes',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: ZWColors.orange)),
          ),
          _StepperButton(
            icon: Icons.add,
            onTap: () => setState(() => _nbPersonnes++),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5))
        ],
      ),
      child: ElevatedButton(
        onPressed: _onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: ZWColors.orange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Voir les recettes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _IngredientQtyRow extends StatelessWidget {
  final Ingredient ingredient;
  final TextEditingController controller;
  final String selectedUnit;
  final Function(String?) onUnitChanged;
  final List<String> availableUnits;

  const _IngredientQtyRow({
    required this.ingredient,
    required this.controller,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.availableUnits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (ingredient.couleur ?? ZWColors.orange).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                ingredient.nom.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ingredient.couleur ?? ZWColors.orange,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              ingredient.nom,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ZWColors.brunFonce,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'Qté',
                filled: true,
                fillColor: ZWColors.beigeInput,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: ZWColors.beigeInput,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: selectedUnit,
              items: availableUnits.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: onUnitChanged,
              underline: const SizedBox(),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ZWColors.brunFonce),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _TempsOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TempsOption({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? ZWColors.orangeLight : ZWColors.beigeInput,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? ZWColors.orange : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? ZWColors.orange : ZWColors.taupe,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(color: ZWColors.beigeInput, shape: BoxShape.circle),
        child: Icon(icon, color: ZWColors.brunFonce, size: 20),
      ),
    );
  }
}
