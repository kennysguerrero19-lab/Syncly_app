import 'package:flutter/material.dart';
import 'dart:async';

const logoUrl = 'https://i.imgur.com/your_logo.png'; // Cambia por la URL de tu logo

class BeautifulSplashScreen extends StatefulWidget {
  @override
  State<BeautifulSplashScreen> createState() => _BeautifulSplashScreenState();
}

class _BeautifulSplashScreenState extends State<BeautifulSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 32,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(logoUrl),
                    ),
                  ),
                  SizedBox(height: 36),
                  Text(
                    'Syncly',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          blurRadius: 12,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Conectando equipos, creando futuro',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}