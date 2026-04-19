import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import '../../screens/Authentication/login_form.dart';
import '../../screens/Authentication/signup_form.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZWColors.fondPrincipal,
      body: SafeArea(
        // On retire le SingleChildScrollView ici pour éviter les conflits de taille
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 32.0),
              _buildTabSelection(),
              const SizedBox(height: 24.0),
              // On utilise Expanded pour que le contenu occupe le reste de l'écran
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    LoginForm(), // Retire le "const" ici si LoginForm n'est pas un widget const
                    SignUpForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: ZWColors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.restaurant_menu, // Chef hat icon
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'ZeroWaste',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ZWColors.brunFonce,
          ),
        ),
        const Text(
          'Cuisine marocaine anti-gaspillage',
          style: TextStyle(
            fontSize: 16,
            color: ZWColors.taupe,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSelection() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator:
        BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
            colors: [ZWColors.orange, ZWColors.safran],
          ),
        ),
        labelColor: ZWColors.blanc,
        unselectedLabelColor: ZWColors.brunFonce,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        tabs: const [
          Tab(text: 'Connexion'),
          Tab(text: 'Inscription'),
        ],
      ),
    );
  }
}