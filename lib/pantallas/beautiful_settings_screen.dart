import 'package:flutter/material.dart';

class BeautifulSettingsScreen extends StatefulWidget {
  @override
  State<BeautifulSettingsScreen> createState() => _BeautifulSettingsScreenState();
}

class _BeautifulSettingsScreenState extends State<BeautifulSettingsScreen> {
  bool darkMode = true;
  bool notifications = true;
  bool publicProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1A2F),
        elevation: 8,
        shadowColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Configuración', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        children: [
          // Perfil
          Card(
            color: Color(0xFF142A47),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            elevation: 12,
            shadowColor: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('knjnkk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('keee@gmail.com', style: TextStyle(color: Colors.white70, fontSize: 15)),
                        Text('Diseñadora UI/UX', style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22),
          // Opciones principales
          Card(
            color: Color(0xFF142A47),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            elevation: 8,
            shadowColor: Colors.blueAccent,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.edit, color: Colors.blueAccent),
                  title: Text('Editar Perfil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                Divider(height: 1, color: Colors.white12),
                ListTile(
                  leading: Icon(Icons.lock, color: Colors.blueAccent),
                  title: Text('Privacidad y Seguridad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 20),
                  onTap: () {
                    Navigator.pushNamed(context, '/privacy');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          // Preferencias
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('PREFERENCIAS', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Card(
            color: Color(0xFF142A47),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            elevation: 8,
            shadowColor: Colors.blueAccent,
            child: Column(
              children: [
                SwitchListTile(
                  value: notifications,
                  onChanged: (v) => setState(() => notifications = v),
                  title: Text('Notificaciones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  activeColor: Colors.blueAccent,
                ),
                Divider(height: 1, color: Colors.white12),
                SwitchListTile(
                  value: darkMode,
                  onChanged: (v) => setState(() => darkMode = v),
                  title: Text('Modo Oscuro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  activeColor: Colors.blueAccent,
                ),
                Divider(height: 1, color: Colors.white12),
                SwitchListTile(
                  value: publicProfile,
                  onChanged: (v) => setState(() => publicProfile = v),
                  title: Text('Perfil Público', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  activeColor: Colors.blueAccent,
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          // Soporte
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('SOPORTE', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Card(
            color: Color(0xFF142A47),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            elevation: 8,
            shadowColor: Colors.blueAccent,
            child: ListTile(
              leading: Icon(Icons.help_outline, color: Colors.blueAccent),
              title: Text('Centro de Ayuda', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 20),
              onTap: () {
                Navigator.pushNamed(context, '/help_center');
              },
            ),
          ),
          SizedBox(height: 32),
          // Botón cerrar sesión
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                shadowColor: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout, color: Colors.white),
              label: Text('Cerrar Sesión', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
            ),
          ),
        ],
      ),
    );
  }
}