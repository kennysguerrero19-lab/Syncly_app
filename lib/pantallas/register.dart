import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BeautifulRegisterScreen extends StatefulWidget {
  @override
  State<BeautifulRegisterScreen> createState() => _BeautifulRegisterScreenState();
}

class _BeautifulRegisterScreenState extends State<BeautifulRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nombre, _apellido, _correo, _telefono, _fechaNacimiento, _genero;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  // avatar URL not used in register form
  bool isLoading = false;
  String? _lastError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(height: 24),
                Card(
                  color: Color(0xFF142A47),
                  elevation: 16,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text('Registro', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.blueAccent, letterSpacing: 1.2)),
                          SizedBox(height: 24),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                              labelText: 'Nombre',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || value.isEmpty ? 'Ingrese su nombre' : null,
                            onSaved: (value) => _nombre = value,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline, color: Colors.blueAccent),
                              labelText: 'Apellido',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || value.isEmpty ? 'Ingrese su apellido' : null,
                            onSaved: (value) => _apellido = value,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                              labelText: 'Correo electrónico',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || !value.contains('@') ? 'Ingrese un correo válido' : null,
                            onSaved: (value) => _correo = value,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                              suffixIcon: IconButton(
                                icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.blueAccent),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || value.length < 6 ? 'Mínimo 6 caracteres' : null,
                            onSaved: (value) => null,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmController,
                            obscureText: !_showConfirmPassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
                              labelText: 'Confirmar contraseña',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                              suffixIcon: IconButton(
                                icon: Icon(_showConfirmPassword ? Icons.visibility : Icons.visibility_off, color: Colors.blueAccent),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword = !_showConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value != _passwordController.text ? 'Las contraseñas no coinciden' : null,
                            onSaved: (value) => null,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                              labelText: 'Teléfono',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            validator: (value) => value == null || value.length < 8 ? 'Ingrese un teléfono válido' : null,
                            onSaved: (value) => _telefono = value,
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.cake, color: Colors.blueAccent),
                              labelText: 'Fecha de nacimiento',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            onSaved: (value) => _fechaNacimiento = value,
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.wc, color: Colors.blueAccent),
                              labelText: 'Género',
                              labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                              filled: true,
                              fillColor: Color(0xFF1B3556),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                            ),
                            dropdownColor: Color(0xFF142A47),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            items: [
                              DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                              DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                              DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                            ],
                            onChanged: (value) => setState(() => _genero = value),
                            onSaved: (value) => _genero = value,
                          ),
                          SizedBox(height: 24),
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
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          setState(() { isLoading = true; });
                                          ApiService.register('$_nombre $_apellido', _correo ?? '', _passwordController.text, phone: _telefono, birthDate: _fechaNacimiento, gender: _genero).then((resp) {
                                            setState(() { isLoading = false; });
                                            if (resp['success']) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text('¡Registro exitoso! Por favor inicia sesión.', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                                                  );
                                                  // After register, go to login so user signs in
                                                  Navigator.pushReplacementNamed(context, '/login');
                                                } else {
                                              String msg = 'Error al registrar';
                                              final err = resp['error'];
                                              if (err is String) msg = err;
                                              else if (err is Map && err['msg'] != null) msg = err['msg'];
                                              setState(() { _lastError = msg; });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(msg, style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                                              );
                                            }
                                          }).catchError((err) {
                                            setState(() { isLoading = false; });
                                            setState(() { _lastError = err.toString(); });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Error de conexión', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                                            );
                                          });
                                        }
                                      },
                                      child: Text('Registrarse', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1)),
                                    ),
                                  ),
                          ),
                            if (_lastError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)),
                                  child: Text(_lastError!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                          SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text('¿Ya tienes cuenta? Inicia sesión', style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.w600, fontSize: 16)),
                          ),
                        ],
                      ),
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
