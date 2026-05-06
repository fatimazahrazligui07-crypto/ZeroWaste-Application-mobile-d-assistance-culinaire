import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstnameController.text = 'Utilisateur'; // À remplacer par les vraies données
    _lastnameController.text = 'Chef';
    _usernameController.text = 'utilisateur.chef';
    _emailController.text = 'chef@zerowaste.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      appBar: AppBar(
        title: const Text('Modifier le Profil', style: TextStyle(color: ZWColors.brunFonce, fontWeight: FontWeight.bold)),
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
              _buildTextField(_firstnameController, 'Prénom', Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(_lastnameController, 'Nom de famille', Icons.person_outline),
              const SizedBox(height: 16),
              _buildTextField(_usernameController, 'Nom d\'utilisateur', Icons.alternate_email),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Email', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 32),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: ZWColors.brunFonce, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: ZWColors.taupe),
            filled: true,
            fillColor: ZWColors.beigeInput,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: ZWColors.orange, width: 1.5)),
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
        child: const Text('Enregistrer les modifications', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
