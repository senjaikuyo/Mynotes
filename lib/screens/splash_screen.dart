import 'package:flutter/material.dart';
import '../theme/neobrutalism.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 104,
                  height: 104,
                  decoration: NeoBox.decoration(
                    color: NeoColors.primary,
                    radius: 16,
                    borderWidth: 3.0,
                    shadowOffset: const Offset(5, 5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.edit_note_rounded,
                      size: 64,
                      color: NeoColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'MyNotes',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    color: NeoColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const NeoBadge(
                  text: 'Catat Harianmu',
                  color: NeoColors.secondary,
                  fontSize: 11,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Simpan setiap ide, rencana, dan momen berharga dalam satu tempat.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: NeoColors.black,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 160,
                  height: 16,
                  decoration: NeoBox.decoration(
                    color: Colors.white,
                    radius: 8,
                    borderWidth: 2.0,
                    shadowOffset: const Offset(3, 3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: const LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(NeoColors.accent),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
