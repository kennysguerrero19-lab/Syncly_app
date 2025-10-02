import 'package:flutter/material.dart';

class BeautifulLoginScreen extends StatefulWidget {
  @override
  State<BeautifulLoginScreen> createState() => _BeautifulLoginScreenState();
}

class _BeautifulLoginScreenState extends State<BeautifulLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  bool emailError = false;
  bool passwordError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                Hero(
                  tag: 'logo',
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF3AB4F2), Color(0xFFB36AFF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF3AB4F2).withOpacity(0.4),
                          blurRadius: 28,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('lib/assets/logo_syncly.png'),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Card(
                  color: Color(0xFF142A47),
                  elevation: 16,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      children: [
                        Text('Iniciar Sesión', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.blueAccent, letterSpacing: 1.2)),
                        SizedBox(height: 28),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                            filled: true,
                            fillColor: Color(0xFF1B3556),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.blueAccent, width: 1.2)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)),
                            errorText: emailError ? 'Ingresa tu correo' : null,
                          ),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 18),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                            filled: true,
                            fillColor: Color(0xFF1B3556),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.blueAccent, width: 1.2)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)),
                            errorText: passwordError ? 'Ingresa tu contraseña' : null,
                          ),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 28),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.blueAccent)
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      padding: EdgeInsets.symmetric(horizontal: 56, vertical: 20),
                                      elevation: 12,
                                      shadowColor: Colors.lightBlueAccent,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        errorMessage = null;
                                        emailError = false;
                                        passwordError = false;
                                      });
                                      final email = emailController.text.trim();
                                      final password = passwordController.text.trim();
                                      bool hasError = false;
                                      if (email.isEmpty) {
                                        setState(() { emailError = true; });
                                        hasError = true;
                                      }
                                      if (password.isEmpty) {
                                        setState(() { passwordError = true; });
                                        hasError = true;
                                      }
                                      if (hasError) return;
                                      setState(() { isLoading = true; });
                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() { isLoading = false; });
                                        Navigator.pushReplacementNamed(context, '/home');
                                      });
                                    },
                                    child: Text('Entrar', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1)),
                                  ),
                                ),
                        ),
                        SizedBox(height: 18),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                          child: Text('¿No tienes cuenta? Regístrate', style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

