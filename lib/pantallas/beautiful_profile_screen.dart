import 'package:flutter/material.dart';

class BeautifulProfileScreen extends StatefulWidget {
  @override
  State<BeautifulProfileScreen> createState() => _BeautifulProfileScreenState();
}

class _BeautifulProfileScreenState extends State<BeautifulProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController bioController;
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'Ana García');
    emailController = TextEditingController(text: 'ana@email.com');
    phoneController = TextEditingController(text: '+57 300 123 4567');
    bioController = TextEditingController(text: 'Diseñadora UX/UI apasionada por la tecnología.');
    avatarUrl = 'https://i.pravatar.cc/150?img=1';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Color(0xFF0A1A2F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1A2F),
        elevation: 8,
        shadowColor: Colors.blueAccent,
        title: Text('Perfil', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
          elevation: 16,
          color: Color(0xFF142A47),
          shadowColor: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.blueAccent,
                        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                        child: avatarUrl == null ? Icon(Icons.person, color: Colors.white, size: 54) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              avatarUrl = 'https://i.pravatar.cc/150?img=8';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: bioController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                          elevation: 8,
                          shadowColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Perfil guardado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                          );
                        },
                        icon: Icon(Icons.save, color: Colors.white),
                        label: Text('Guardar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                          elevation: 8,
                          shadowColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text('Cerrar Sesión', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
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
