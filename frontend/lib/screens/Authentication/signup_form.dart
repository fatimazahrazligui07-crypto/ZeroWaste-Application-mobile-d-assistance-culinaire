import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../services/auth_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmationVisible = false;
  bool _isLoading = false;

  // Password validation criteria
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigit = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.removeListener(_validatePassword);
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasDigit = password.contains(RegExp(r'[0-9]'));
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await AuthService().signup(
          _firstnameController.text,
          _lastnameController.text.isEmpty ? null : _lastnameController.text,
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
          _passwordConfirmationController.text,
        );

        if (response['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inscription réussie !')),
          );
          // TODO: Naviguer vers l'écran principal ou l'écran de connexion
        } else {
          String errorMessage = response['message'] ?? 'Une erreur est survenue';
          if (response['errors'] != null) {
            // Handle validation errors from Laravel
            Map<String, dynamic> errors = response['errors'];
            errors.forEach((key, value) {
              errorMessage += '\n- ${value[0]}'; // Affiche le premier message d'erreur pour chaque champ
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur réseau: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _firstnameController,
            labelText: 'Prénom',
            hintText: 'Fatima',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre prénom';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            controller: _lastnameController,
            labelText: 'Nom de famille (optionnel)',
            hintText: 'El Amrani',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            controller: _usernameController,
            labelText: 'Nom d\'utilisateur',
            hintText: 'fatima.elamrani',
            icon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un nom d\'utilisateur';
              }
              if (value.length < 3) {
                return 'Le nom d\'utilisateur doit contenir au moins 3 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          _buildTextField(
            controller: _emailController,
            labelText: 'Email',
            hintText: 'vous@exemple.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          _buildPasswordField(
            controller: _passwordController,
            labelText: 'Mot de passe',
            isConfirmation: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre mot de passe';
              }
              if (!_hasMinLength || !_hasUppercase || !_hasLowercase || !_hasDigit) {
                return 'Le mot de passe ne respecte pas tous les critères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          _buildPasswordField(
            controller: _passwordConfirmationController,
            labelText: 'Confirmer le mot de passe',
            isConfirmation: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez confirmer votre mot de passe';
              }
              if (value != _passwordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          _buildPasswordRequirements(),
          const SizedBox(height: 24.0),
          _buildSignUpButton(),
          const SizedBox(height: 16.0),
          _buildTermsAndConditions(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: ZWColors.brunFonce,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: ZWColors.taupe),
            filled: true,
            fillColor: ZWColors.beigeInput,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: ZWColors.orange, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          ),
          style: const TextStyle(color: ZWColors.brunFonce),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isConfirmation,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: ZWColors.brunFonce,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          obscureText: isConfirmation ? !_isPasswordConfirmationVisible : !_isPasswordVisible,
          validator: validator,
          decoration: InputDecoration(
            hintText: '********',
            prefixIcon: const Icon(Icons.lock_outline, color: ZWColors.taupe),
            suffixIcon: IconButton(
              icon: Icon(
                isConfirmation
                    ? (_isPasswordConfirmationVisible ? Icons.visibility : Icons.visibility_off)
                    : (_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                color: ZWColors.taupe,
              ),
              onPressed: () {
                setState(() {
                  if (isConfirmation) {
                    _isPasswordConfirmationVisible = !_isPasswordConfirmationVisible;
                  } else {
                    _isPasswordVisible = !_isPasswordVisible;
                  }
                });
              },
            ),
            filled: true,
            fillColor: ZWColors.beigeInput,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: ZWColors.orange, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          ),
          style: const TextStyle(color: ZWColors.brunFonce),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ZWColors.beigeInput,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: ZWColors.taupe),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Votre mot de passe doit contenir :',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ZWColors.brunFonce,
            ),
          ),
          const SizedBox(height: 8.0),
          _buildRequirementRow('Au moins 8 caractères', _hasMinLength),
          _buildRequirementRow('Une lettre majuscule et minuscule', _hasUppercase && _hasLowercase),
          _buildRequirementRow('Un chiffre', _hasDigit),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, bool meetsRequirement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            meetsRequirement ? Icons.check_circle : Icons.circle_outlined,
            color: meetsRequirement ? ZWColors.vertBasilic : ZWColors.taupe,
            size: 18,
          ),
          const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: meetsRequirement ? ZWColors.brunFonce : ZWColors.taupe,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent, // Make button transparent to show gradient
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ZWColors.orange, ZWColors.safran],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 50.0), // min sizes for Material buttons
            child: _isLoading
                ? const CircularProgressIndicator(color: ZWColors.blanc)
                : const Text(
              'Créer mon compte',
              style: TextStyle(
                color: ZWColors.blanc,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return const Text(
      'En créant un compte, vous acceptez nos conditions d\'utilisation et notre politique de confidentialité',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ZWColors.taupe,
        fontSize: 12,
      ),
    );
  }
}