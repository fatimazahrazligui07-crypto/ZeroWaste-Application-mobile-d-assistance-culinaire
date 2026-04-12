import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/frigo/mon_frigo_screen.dart';
import 'screens/recettes/recettes_screen.dart';
import 'screens/profil/profil_screen.dart';
import 'core/theme/colors.dart';

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
      initialRoute: '/home',
      routes: {
        '/home':     (_) => const HomeScreen(),
        '/frigo':    (_) => const MonFrigoScreen(),
        '/recettes': (_) => const RecettesScreen(),
        '/profil':   (_) => const ProfilScreen(),
      },
    );
  }
}
