import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';
import '../services/api_service.dart';

// Profile screen: fetches authenticated user from backend and shows editable fields

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
  DateTime? _birthDate;
  String? _gender;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    phoneController = TextEditingController(text: '');
    bioController = TextEditingController(text: '');
    avatarUrl = 'https://i.pravatar.cc/150?img=1';

    // Load current user from API
    _loadCurrentUser();
  }

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loadCurrentUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final res = await ApiService.getCurrentUser();
    if (res['success'] && res['data'] is Map) {
      final data = res['data'] as Map<String, dynamic>;
      // The backend returns the user under 'user' or directly; handle both
      final user = data['user'] ?? data;
      setState(() {
        nameController.text = user['name'] ?? '';
        emailController.text = user['email'] ?? '';
        phoneController.text = user['phone'] ?? '';
        bioController.text = user['bio'] ?? '';
        // parse birthDate if present (expecting ISO or simple string)
        try {
          if (user['birthDate'] != null && (user['birthDate'] as String).isNotEmpty) {
            _birthDate = DateTime.tryParse(user['birthDate']) ?? DateTime.fromMillisecondsSinceEpoch(0);
            // if parse failed and epoch 0, fall back to null
            if (_birthDate!.year == 1970) _birthDate = null;
          } else {
            _birthDate = null;
          }
        } catch (e) {
          _birthDate = null;
        }
        _gender = user['gender'] ?? null;
        // prefer avatar if present
        if (user['avatarUrl'] != null && (user['avatarUrl'] as String).isNotEmpty) {
          avatarUrl = user['avatarUrl'];
        }
      });
    } else {
      setState(() {
        _errorMessage = res['error']?.toString() ?? 'No se pudo cargar el perfil';
      });
    }
    setState(() {
      _isLoading = false;
    });
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
      appBar: SafeBackAppBar(title: 'Perfil'),
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
                    if (_isLoading)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LinearProgressIndicator(minHeight: 4, color: Colors.blueAccent, backgroundColor: Colors.white12),
                      ),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(_errorMessage!, style: TextStyle(color: Colors.redAccent)),
                      ),
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
                    readOnly: true,
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
                  // Birth date picker
                  GestureDetector(
                    onTap: () async {
                      final now = DateTime.now();
                      final initial = _birthDate ?? DateTime(now.year - 18, now.month, now.day);
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: initial,
                        firstDate: DateTime(1900),
                        lastDate: now,
                      );
                      if (picked != null) setState(() => _birthDate = picked);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Fecha de nacimiento',
                          labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          filled: true,
                          fillColor: Color(0xFF1B3556),
                        ),
                        controller: TextEditingController(text: _birthDate != null ? '${_birthDate!.day.toString().padLeft(2,'0')}/${_birthDate!.month.toString().padLeft(2,'0')}/${_birthDate!.year}' : ''),
                        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Gender dropdown
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: InputDecoration(
                      labelText: 'Género',
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                    ),
                    dropdownColor: Color(0xFF142A47),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    items: [
                      DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                      DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                      DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                    ],
                    onChanged: (value) => setState(() => _gender = value),
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
                        onPressed: _isLoading ? null : () async {
                          setState(() { _isLoading = true; _errorMessage = null; });
                          final updates = {
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'birthDate': null,
                            'gender': null,
                            // Note: we don't allow email change here
                          };
                          final res = await ApiService.updateProfile(updates);
                          if (res['success'] && res['data'] is Map) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Perfil actualizado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                            );
                            // Navigate to settings where the updated profile appears
                            Navigator.pushReplacementNamed(context, '/settings');
                          } else {
                            setState(() { _errorMessage = res['error']?.toString() ?? 'Error al actualizar'; });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(_errorMessage!, style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                            );
                          }
                          setState(() { _isLoading = false; });
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
