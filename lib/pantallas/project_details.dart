
import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';

class BeautifulProjectDetailsScreen extends StatefulWidget {
  @override
  State<BeautifulProjectDetailsScreen> createState() => _BeautifulProjectDetailsScreenState();
}

class _BeautifulProjectDetailsScreenState extends State<BeautifulProjectDetailsScreen> {
  bool showEditForm = false;
  final _formKey = GlobalKey<FormState>();
  String title = 'App Educativa';
  String desc = 'Interfaz intuitiva para aprendizaje de lecciones.';
  double progress = 0.7;
  List<String> tags = ['UI/UX', 'Figma', 'Prototipado'];
  List<String> members = ['Ana', 'Carlos', 'Lucía'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      appBar: SafeBackAppBar(title: 'Detalles del Proyecto'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 8,
          color: Colors.black.withOpacity(0.95),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              child: showEditForm
                  ? Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Editar Proyecto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                          SizedBox(height: 18),
                          TextFormField(
                            initialValue: title,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Título',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF232323),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'El título es requerido' : null,
                            onSaved: (v) => title = v ?? title,
                          ),
                          SizedBox(height: 14),
                          TextFormField(
                            initialValue: desc,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Descripción',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF232323),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'La descripción es requerida' : null,
                            onSaved: (v) => desc = v ?? desc,
                          ),
                          SizedBox(height: 14),
                          Text('Progreso', style: TextStyle(color: Colors.white70)),
                          Slider(
                            value: progress,
                            min: 0,
                            max: 1,
                            divisions: 10,
                            label: '${(progress * 100).toInt()}%',
                            activeColor: Color(0xFF00E6E6),
                            onChanged: (v) => setState(() => progress = v),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
                                onPressed: () => setState(() => showEditForm = false),
                              ),
                              SizedBox(width: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00E6E6)),
                                child: Text('Guardar', style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    _formKey.currentState?.save();
                                    setState(() => showEditForm = false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Proyecto actualizado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Row(
                    children: [
                      Icon(Icons.folder_special, color: Color(0xFF00E6E6), size: 36),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('App Educativa', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                      ),
                      Icon(Icons.star, color: Color(0xFFFFD600)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text('Interfaz intuitiva para aprendizaje de lecciones.', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('UI/UX', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF00E6E6)),
                      Chip(label: Text('Figma', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF00E6E6)),
                      Chip(label: Text('Prototipado', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF00E6E6)),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Color(0xFFB36AFF), size: 20),
                      SizedBox(width: 8),
                      Text('Entrega: 30/09/2025', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.group, color: Color(0xFFB36AFF), size: 22),
                      SizedBox(width: 6),
                      Text('Miembros:', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 6),
                      ...['Ana', 'Carlos', 'Lucía'].map((m) => Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Chip(
                          label: Text(m, style: TextStyle(color: Colors.white)),
                          backgroundColor: Color(0xFF232323),
                          shape: StadiumBorder(side: BorderSide(color: Color(0xFF00E6E6), width: 1)),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Text('Progreso:', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.white12,
                          color: Color(0xFF00E6E6),
                          minHeight: 8,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('70%', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00E6E6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        onPressed: () => setState(() => showEditForm = true),
                        icon: Icon(Icons.edit, color: Colors.white),
                        label: Text('Editar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7A00),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.white),
                        label: Text('Eliminar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
