import 'package:flutter/material.dart';

class BeautifulMessagesScreen extends StatefulWidget {
  @override
  State<BeautifulMessagesScreen> createState() => _BeautifulMessagesScreenState();
}

class _BeautifulMessagesScreenState extends State<BeautifulMessagesScreen> {
  List<Map<String, dynamic>> messages = [
    {
      'title': 'Ana García',
      'preview': '¿Listo para la reunión?',
      'time': '10:30',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'unread': true,
    },
    {
      'title': 'Carlos Méndez',
      'preview': 'Te envié el archivo.',
      'time': 'Ayer',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'unread': false,
    },
  ];

  void _addMessage() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final previewController = TextEditingController();
        return AlertDialog(
          backgroundColor: Color(0xFF232323),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Nuevo Mensaje', style: TextStyle(color: Colors.white)),
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
                controller: previewController,
                decoration: InputDecoration(labelText: 'Mensaje', labelStyle: TextStyle(color: Colors.white70)),
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
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00E6E6)),
              child: Text('Agregar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (nameController.text.trim().isEmpty || previewController.text.trim().isEmpty) return;
                Navigator.pop(context, {
                  'title': nameController.text.trim(),
                  'preview': previewController.text.trim(),
                  'time': 'Ahora',
                  'avatar': 'https://i.pravatar.cc/150?img=${messages.length + 3}',
                  'unread': true,
                });
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      setState(() {
        messages.insert(0, result);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mensaje agregado', style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF00E6E6)),
      );
    }
  }

  void _removeMessage(int idx) {
    setState(() {
      messages.removeAt(idx);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mensaje eliminado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
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
        title: Text('Mensajes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Nuevo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: _addMessage,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, i) {
            final m = messages[i];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 12,
              color: Color(0xFF142A47),
              shadowColor: Colors.blueAccent,
              margin: EdgeInsets.only(bottom: 20),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: m['unread'] ? Colors.blueAccent : Colors.lightBlueAccent,
                  backgroundImage: NetworkImage(m['avatar']),
                ),
                title: Row(
                  children: [
                    Expanded(child: Text(m['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                    Text(m['time'], style: TextStyle(color: Colors.white54, fontSize: 14)),
                  ],
                ),
                subtitle: Text(m['preview'], style: TextStyle(color: Colors.white70, fontSize: 15)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (m['unread'])
                      Icon(Icons.mark_email_unread, color: Colors.blueAccent),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _removeMessage(i),
                      tooltip: 'Eliminar',
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/chat');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
