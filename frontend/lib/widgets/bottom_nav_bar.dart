import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/colors.dart';
import '../core/constants/icons.dart';

class ZWBottomNavBar extends StatelessWidget {
  final int currentIndex; // 0=Home 1=Frigo 2=Recettes 3=Profil

  const ZWBottomNavBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/frigo');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/recettes');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: const BoxDecoration(
        color: ZWColors.blanc,
        border: Border(top: BorderSide(color: Color(0xFFF0E8DF))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, ZWIcons.home,     'Accueil',  0),
          _navItem(context, ZWIcons.frigo,    'Frigo',    1),
          _navItem(context, ZWIcons.recettes, 'Recettes', 2),
          _navItem(context, ZWIcons.profil,   'Profil',   3),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String svgStr, String label, int index) {
    final isActive = currentIndex == index;
    final color = isActive ? ZWColors.orange : ZWColors.taupe;
    return GestureDetector(
      onTap: () => _onTap(context, index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.string(svgStr,
              width: 24, height: 24,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          const SizedBox(height: 3),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400)),
        ],
      ),
    );
  }
}