import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Mon Profil',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: ZWColors.brunFonce)),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: ZWColors.orange,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    const Text('Utilisateur Chef',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ZWColors.brunFonce)),
                    const Text('chef@zerowaste.com',
                        style: TextStyle(fontSize: 14, color: ZWColors.taupe)),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _profileOption(Icons.history, 'Historique des recettes'),
              _profileOption(Icons.favorite_border, 'Mes favoris'),
              _profileOption(Icons.settings_outlined, 'Paramètres'),
              _profileOption(Icons.help_outline, 'Aide et Support'),
              const SizedBox(height: 20),
              _profileOption(Icons.logout, 'Déconnexion', isLogout: true),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ZWBottomNavBar(currentIndex: 3),
    );
  }

  Widget _profileOption(IconData icon, String title, {bool isLogout = false}) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : ZWColors.orange),
            const SizedBox(width: 15),
            Text(title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isLogout ? Colors.red : ZWColors.brunFonce)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: ZWColors.taupe),
          ],
        ),
      );
}
