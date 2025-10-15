import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';

class BeautifulPrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: SafeBackAppBar(title: 'Privacidad y Seguridad'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Color(0xFF142A47),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                elevation: 12,
                shadowColor: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.security, color: Colors.blueAccent, size: 38),
                          SizedBox(width: 14),
                          Expanded(
                            child: Text('Tu privacidad y seguridad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Nos tomamos muy en serio la protección de tus datos y tu experiencia.', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Card(
                color: Color(0xFF232323),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.lock, color: Colors.blueAccent, size: 30),
                        title: Text('Datos cifrados', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Toda tu información está protegida y cifrada con los más altos estándares de seguridad.', style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white12),
                      ListTile(
                        leading: Icon(Icons.visibility, color: Colors.purpleAccent, size: 30),
                        title: Text('Control de visibilidad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Tú decides quién puede ver tus proyectos y tu perfil. Configura tu privacidad fácilmente.', style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white12),
                      ListTile(
                        leading: Icon(Icons.shield, color: Colors.greenAccent, size: 30),
                        title: Text('Sin terceros', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('No compartimos tu información con nadie más. Tu privacidad es nuestra prioridad.', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
