import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      appBar: AppBar(
        title: const Text('Paramètres', style: TextStyle(color: ZWColors.brunFonce, fontWeight: FontWeight.bold)),
        backgroundColor: ZWColors.fondPrincipal,
        elevation: 0,
        iconTheme: const IconThemeData(color: ZWColors.brunFonce),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _settingsOption(context, Icons.person_outline, 'Informations personnelles', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
            }),
            _settingsOption(context, Icons.lock_outline, 'Changer le mot de passe', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
            }),
            _settingsOption(context, Icons.notifications_none, 'Notifications', () {}),
          ],
        ),
      ),
    );
  }

  Widget _settingsOption(BuildContext context, IconData icon, String title, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
          ),
          child: Row(
            children: [
              Icon(icon, color: ZWColors.orange),
              const SizedBox(width: 15),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: ZWColors.brunFonce)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: ZWColors.taupe),
            ],
          ),
        ),
      );
}
