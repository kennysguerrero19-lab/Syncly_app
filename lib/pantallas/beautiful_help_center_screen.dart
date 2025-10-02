import 'package:flutter/material.dart';

class BeautifulHelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        elevation: 0,
        title: Text('Centro de Ayuda', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
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
                  child: Row(
                    children: [
                      Icon(Icons.help_outline, color: Colors.blueAccent, size: 38),
                      SizedBox(width: 14),
                      Expanded(
                        child: Text('¿Necesitas ayuda?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
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
                        leading: Icon(Icons.question_answer, color: Colors.purpleAccent, size: 30),
                        title: Text('Preguntas frecuentes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Respuestas rápidas a las dudas más comunes.', style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white12),
                      ListTile(
                        leading: Icon(Icons.contact_support, color: Colors.blueAccent, size: 30),
                        title: Text('Contacto de soporte', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Estamos aquí para ayudarte en lo que necesites.', style: TextStyle(color: Colors.white70)),
                      ),
                      Divider(color: Colors.white12),
                      ListTile(
                        leading: Icon(Icons.menu_book, color: Colors.greenAccent, size: 30),
                        title: Text('Guías de uso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Aprende a usar la app paso a paso.', style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 28),
              Card(
                color: Color(0xFF142A47),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¿Quieres hablar con soporte?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                        icon: Icon(Icons.chat, color: Colors.white),
                        label: Text('Chatear con soporte', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/support_chat');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
