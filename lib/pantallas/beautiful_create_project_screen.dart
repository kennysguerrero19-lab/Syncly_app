import 'package:flutter/material.dart';
import '../widgets/safe_back_appbar.dart';

class BeautifulCreateProjectScreen extends StatefulWidget {
  @override
  State<BeautifulCreateProjectScreen> createState() => _BeautifulCreateProjectScreenState();
}

class _BeautifulCreateProjectScreenState extends State<BeautifulCreateProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController memberController = TextEditingController();
  DateTime? deadline;
  Color selectedColor = Color(0xFF00E6E6);
  List<String> members = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Color(0xFF0A1A2F),
      appBar: SafeBackAppBar(title: 'Crear Proyecto'),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            elevation: 16,
            color: Color(0xFF142A47),
            shadowColor: Colors.blueAccent,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nuevo Proyecto', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent, letterSpacing: 1.2)),
                  SizedBox(height: 28),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre del Proyecto',
                      prefixIcon: Icon(Icons.title, color: Colors.blueAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 18),
                  TextField(
                    controller: descController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      prefixIcon: Icon(Icons.description, color: Colors.lightBlueAccent),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Color(0xFF1B3556),
                      labelStyle: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.color_lens, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('Color:', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 10),
                      ...[
                        Colors.blueAccent,
                        Colors.lightBlueAccent,
                        Color(0xFF00E6E6),
                        Color(0xFF1B3556),
                      ].map((c) => GestureDetector(
                        onTap: () => setState(() => selectedColor = c),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(color: selectedColor == c ? Colors.white : Colors.transparent, width: 2),
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('Fecha de entrega:', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: deadline ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                data: ThemeData.dark(),
                                child: child!,
                              ),
                            );
                            if (picked != null) setState(() => deadline = picked);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFF1B3556),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              deadline == null ? 'Seleccionar' : '${deadline!.day}/${deadline!.month}/${deadline!.year}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(Icons.group, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('Miembros:', style: TextStyle(color: Colors.white70)),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: memberController,
                          decoration: InputDecoration(
                            hintText: 'Agregar miembro',
                            hintStyle: TextStyle(color: Colors.white38),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                            filled: true,
                            fillColor: Color(0xFF1B3556),
                          ),
                          style: TextStyle(color: Colors.white),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              setState(() {
                                members.add(value.trim());
                                memberController.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  if (members.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: members.map((m) => Chip(
                        label: Text(m, style: TextStyle(color: Colors.white)),
                        backgroundColor: selectedColor.withOpacity(0.7),
                        deleteIcon: Icon(Icons.close, color: Colors.white70, size: 18),
                        onDeleted: () => setState(() => members.remove(m)),
                      )).toList(),
                    ),
                  SizedBox(height: 32),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: isLoading
                        ? CircularProgressIndicator(color: selectedColor)
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedColor,
                                padding: EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                                elevation: 8,
                                shadowColor: Colors.blueAccent,
                              ),
                              onPressed: () {
                                if (nameController.text.trim().isEmpty || descController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Completa todos los campos', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                                  );
                                  return;
                                }
                                setState(() { isLoading = true; });
                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() { isLoading = false; });
                                  final newProject = {
                                    'title': nameController.text.trim(),
                                    'desc': descController.text.trim(),
                                    'tags': ['Nuevo', 'Flutter'],
                                    'color': selectedColor,
                                    'progress': 0.0,
                                    'members': List<String>.from(members),
                                    'favorite': false,
                                  };
                                  Navigator.pop(context, newProject);
                                });
                              },
                              child: Text('Crear Proyecto', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                            ),
                          ),
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
