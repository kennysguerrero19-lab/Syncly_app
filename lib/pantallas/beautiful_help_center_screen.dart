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
                        leading: Icon(Icons.menu_book, color: Colors.greenAccent, size: 30),
                        title: Text('Guía de uso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Descubre cómo crear proyectos, colaborar y gestionar tu perfil en Syncly. Accede a tutoriales y tips para aprovechar todas las funciones.', style: TextStyle(color: Colors.white70)),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xFF232323),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              title: Text('Guía de uso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('1. Crea tu proyecto desde la pantalla principal.\n', style: TextStyle(color: Colors.white70)),
                                    Text('2. Invita colaboradores y asigna roles.\n', style: TextStyle(color: Colors.white70)),
                                    Text('3. Gestiona tareas y mensajes en tiempo real.\n', style: TextStyle(color: Colors.white70)),
                                    Text('4. Configura la privacidad y visibilidad de tu perfil y proyectos.\n', style: TextStyle(color: Colors.white70)),
                                    Text('5. Consulta notificaciones y ayuda desde el menú.\n', style: TextStyle(color: Colors.white70)),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cerrar', style: TextStyle(color: Colors.blueAccent)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(color: Colors.white12),
                      ListTile(
                        leading: Icon(Icons.question_answer, color: Colors.purpleAccent, size: 30),
                        title: Text('Preguntas frecuentes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('¿Cómo recupero mi contraseña?\n¿Puedo colaborar en varios proyectos?\n¿Mis datos están seguros?', style: TextStyle(color: Colors.white70)),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Color(0xFF232323),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              title: Text('Preguntas frecuentes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('¿Cómo recupero mi contraseña?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text('Puedes solicitar un enlace de recuperación desde la pantalla de login.\n', style: TextStyle(color: Colors.white70)),
                                    SizedBox(height: 12),
                                    Text('¿Puedo colaborar en varios proyectos?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text('Sí, puedes unirte y gestionar múltiples proyectos desde tu perfil.\n', style: TextStyle(color: Colors.white70)),
                                    SizedBox(height: 12),
                                    Text('¿Mis datos están seguros?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    Text('Sí, usamos cifrado y no compartimos tu información con terceros.', style: TextStyle(color: Colors.white70)),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Cerrar', style: TextStyle(color: Colors.blueAccent)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
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
