import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF144272),
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      selectedLabelStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      unselectedItemColor: const Color(0xFFB3B3B3),
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/lend.svg',
            color: Colors.white,
            width: 32,
            height: 32,
          ),
          label: 'Lend',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/post.svg',
            color: Colors.white,
            width: 32,
            height: 32,
          ),
          label: 'Post',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/borrow.svg',
            color: Colors.white,
            width: 32,
            height: 32,
          ),
          label: 'Borrow',
        ),
      ],
    );
  }
}
