import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> diagonalProgress;
  late Animation<double> whiteProgress;
  late Animation<double> logoFade;
  late Animation<double> greenProgress;
  late Animation<double> textFade;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    diagonalProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.15, 0.35, curve: Curves.easeInOut),
      ),
    );

    whiteProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.35, 0.55, curve: Curves.easeInOut),
      ),
    );

    logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.50, 0.65, curve: Curves.easeIn),
      ),
    );

    greenProgress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.70, 0.88, curve: Curves.easeInOut),
      ),
    );

    textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );

    controller.forward();

    Future.delayed(const Duration(milliseconds: 5200), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0F5D49);
    const lightGreen = Color(0xFF6F927F);

    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Animasi 1: kiri hijau muda, kanan hijau tua
              Row(
                children: const [
                  Expanded(
                    child: ColoredBox(color: lightGreen),
                  ),
                  Expanded(
                    child: ColoredBox(color: darkGreen),
                  ),
                ],
              ),

              // Animasi 2: bentuk diagonal
              Opacity(
                opacity: diagonalProgress.value,
                child: Stack(
                  children: [
                    const ColoredBox(
                      color: darkGreen,
                      child: SizedBox.expand(),
                    ),
                    ClipPath(
                      clipper: DiagonalClipper(),
                      child: const ColoredBox(
                        color: lightGreen,
                        child: SizedBox.expand(),
                      ),
                    ),
                  ],
                ),
              ),

              // Animasi 3: putih + logo
              Opacity(
                opacity: whiteProgress.value,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Opacity(
                      opacity: logoFade.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/logo.jpeg',
                            width: 115,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Borneo Scholar',
                            style: TextStyle(
                              color: darkGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Animasi 4: hijau tua + teks putih
              Opacity(
                opacity: greenProgress.value,
                child: Container(
                  color: darkGreen,
                  child: Center(
                    child: Opacity(
                      opacity: textFade.value,
                      child: const Text(
                        'Borneo Scholar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}