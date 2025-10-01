import 'package:flutter/material.dart';

class BeautifulCollaboratorsScreen extends StatefulWidget {
  @override
  State<BeautifulCollaboratorsScreen> createState() => _BeautifulCollaboratorsScreenState();
}

class _BeautifulCollaboratorsScreenState extends State<BeautifulCollaboratorsScreen> {
  List<Map<String, dynamic>> collaborators = [
    {'name': 'Ana García', 'role': 'Diseñadora', 'status': 'Activo', 'avatar': 'https://i.pravatar.cc/150?img=1'},
    {'name': 'Carlos Méndez', 'role': 'Programador', 'status': 'Pendiente', 'avatar': 'https://i.pravatar.cc/150?img=2'},
    {'name': 'Lucía Soto', 'role': 'Gestora', 'status': 'Activo', 'avatar': 'https://i.pravatar.cc/150?img=3'},
  ];

  void _addCollaborator() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final roleController = TextEditingController();
        return AlertDialog(
          backgroundColor: Color(0xFF232323),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Nuevo Colaborador', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre', labelStyle: TextStyle(color: Colors.white70)),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 12),
              TextField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Rol', labelStyle: TextStyle(color: Colors.white70)),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white54)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFB36AFF)),
              child: Text('Agregar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (nameController.text.trim().isEmpty || roleController.text.trim().isEmpty) return;
                Navigator.pop(context, {
                  'name': nameController.text.trim(),
                  'role': roleController.text.trim(),
                  'avatar': 'https://i.pravatar.cc/150?img=${collaborators.length + 4}',
                  'status': 'Activo',
                });
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        collaborators.insert(0, result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Colaborador agregado', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFFB36AFF)),
      );
    }
  }

  void _removeCollaborator(int idx) {
    setState(() {
      collaborators.removeAt(idx);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Colaborador eliminado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1A2F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1A2F),
        elevation: 8,
        shadowColor: Colors.blueAccent,
        title: Text('Colaboradores', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.person_add, color: Colors.white),
        label: Text('Agregar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: _addCollaborator,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar colaborador...',
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                filled: true,
                fillColor: Color(0xFF142A47),
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: collaborators.length,
                itemBuilder: (context, i) {
                  final c = collaborators[i];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    elevation: 12,
                    color: Color(0xFF1B3556),
                    shadowColor: Colors.blueAccent,
                    margin: EdgeInsets.only(bottom: 20),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: c['status'] == 'Activo' ? Colors.blueAccent : Colors.lightBlueAccent,
                        backgroundImage: NetworkImage(c['avatar']),
                        child: c['avatar'] == null ? Icon(Icons.person, color: Colors.white) : null,
                      ),
                      title: Text(c['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['role'], style: TextStyle(color: Colors.white70, fontSize: 15)),
                          Row(
                            children: [
                              Icon(Icons.circle, color: c['status'] == 'Activo' ? Colors.blueAccent : Colors.lightBlueAccent, size: 12),
                              SizedBox(width: 6),
                              Text(c['status'], style: TextStyle(color: c['status'] == 'Activo' ? Colors.blueAccent : Colors.lightBlueAccent, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.chat, color: Colors.blueAccent),
                            onPressed: () {},
                            tooltip: 'Mensaje',
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                            onPressed: () => _removeCollaborator(i),
                            tooltip: 'Eliminar',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
