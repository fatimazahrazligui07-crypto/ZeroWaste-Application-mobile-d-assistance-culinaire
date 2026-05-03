import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      appBar: AppBar(
        title: const Text('Changer le Mot de Passe', style: TextStyle(color: ZWColors.brunFonce, fontWeight: FontWeight.bold)),
        backgroundColor: ZWColors.fondPrincipal,
        elevation: 0,
        iconTheme: const IconThemeData(color: ZWColors.brunFonce),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField(_currentPasswordController, 'Mot de passe actuel'),
              const SizedBox(height: 16),
              _buildPasswordField(_newPasswordController, 'Nouveau mot de passe'),
              const SizedBox(height: 16),
              _buildPasswordField(_confirmPasswordController, 'Confirmer le nouveau mot de passe'),
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: ZWColors.brunFonce, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: !_isVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: ZWColors.taupe),
            suffixIcon: IconButton(
              icon: Icon(_isVisible ? Icons.visibility : Icons.visibility_off, color: ZWColors.taupe),
              onPressed: () => setState(() => _isVisible = !_isVisible),
            ),
            filled: true,
            fillColor: ZWColors.beigeInput,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: ZWColors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Mettre à jour le mot de passe', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
