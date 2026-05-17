import 'package:flutter/material.dart';
import 'package:frontend/services/auth_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/frigo/mon_frigo_screen.dart';
import 'screens/recettes/recettes_list_screen.dart';
import 'screens/profil/profil_screen.dart';
import 'core/theme/colors.dart';
import 'models/recette.dart';
import 'screens/recettes/nutrition_screen.dart'; // ajouter cet import

void main() => runApp(const ZeroWasteApp());

class ZeroWasteApp extends StatelessWidget {
  const ZeroWasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZeroWaste',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: ZWColors.fondPrincipal,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ZWColors.orange,
          primary: ZWColors.orange,
          secondary: ZWColors.safran,
        ),
        useMaterial3: true,
      ),
     // home: const AuthScreen(),
      initialRoute: '/login',
      routes: {
        '/login':    (_) => const AuthScreen(),
        '/home':     (_) => const HomeScreen(), // <-- CHANGEZ CECI (était AuthScreen)
        '/frigo':    (_) => const MonFrigoScreen(),
        '/recettes': (_) => const RecettesListScreen(),
        '/profil':   (_) => const ProfilScreen(),
       // ← Ajouter cette route
  '/recettes/nutrition': (context) {
    final recette = ModalRoute.of(context)!.settings.arguments as Recette;
    return NutritionScreen(recette: recette);
  },
      },
    );
  }
}
