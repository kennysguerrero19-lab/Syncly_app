import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';
import '../services/api_service.dart';

// Settings fetches current user profile to display updated info

class BeautifulSettingsScreen extends StatefulWidget {
  @override
  State<BeautifulSettingsScreen> createState() => _BeautifulSettingsScreenState();
}

class _BeautifulSettingsScreenState extends State<BeautifulSettingsScreen> {
  bool darkMode = true;
  bool notifications = true;
  bool publicProfile = true;
  bool _isLoading = false;
  String? _error;
  String _name = '';
  String _email = '';
  String _bio = '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() { _isLoading = true; _error = null; });
    final res = await ApiService.getCurrentUser();
    if (res['success'] && res['data'] is Map) {
      final data = res['data'] as Map<String, dynamic>;
      final user = data['user'] ?? data;
      setState(() {
        _name = user['name'] ?? '';
        _email = user['email'] ?? '';
        _bio = user['bio'] ?? '';
        _avatarUrl = user['avatarUrl'] ?? null;
      });
    } else {
      setState(() { _error = res['error']?.toString() ?? 'No se pudo cargar perfil'; });
    }
    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      appBar: SafeBackAppBar(title: 'Configuración'),
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
              child: _isLoading
                  ? SizedBox(height: 96, child: Center(child: CircularProgressIndicator(color: Colors.blueAccent)))
                  : _error != null
                      ? SizedBox(height: 96, child: Center(child: Text(_error!, style: TextStyle(color: Colors.redAccent))))
                      : Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.blueAccent,
                              backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                              child: _avatarUrl == null ? Icon(Icons.person, color: Colors.white, size: 36) : null,
                            ),
                            SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                  Text(_email, style: TextStyle(color: Colors.white70, fontSize: 15)),
                                  Text(_bio, style: TextStyle(color: Colors.blueAccent, fontSize: 14)),
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