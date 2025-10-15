import 'package:flutter/material.dart';

class BeautifulNotificationsScreen extends StatefulWidget {
  @override
  State<BeautifulNotificationsScreen> createState() => _BeautifulNotificationsScreenState();
}

class _BeautifulNotificationsScreenState extends State<BeautifulNotificationsScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Invitación recibida',
      'desc': 'El proyecto "Educativo" te ha invitado a colaborar.',
      'type': 'invitacion',
      'actions': ['Aceptar', 'Rechazar'],
      'date': 'Hoy',
    },
    {
      'title': 'Proyecto completado',
      'desc': 'El proyecto "Animado" se ha completado exitosamente.',
      'type': 'completado',
      'actions': [],
      'date': 'Ayer',
    },
    {
      'title': 'Nueva actualización',
      'desc': 'El proyecto "Educativo" tiene nuevas tareas.',
      'type': 'actualizacion',
      'actions': [],
      'date': 'Hace 2 días',
    },
  ];

  void _removeNotification(int idx) {
    setState(() {
      notifications.removeAt(idx);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notificación eliminada', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
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
        title: Text('Notificaciones', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, idx) {
            final notif = notifications[idx];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 12,
              color: Color(0xFF142A47),
              shadowColor: Colors.blueAccent,
              margin: EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          notif['type'] == 'invitacion' ? Icons.mail_outline : notif['type'] == 'completado' ? Icons.check_circle_outline : Icons.update,
                          color: notif['type'] == 'invitacion' ? Colors.blueAccent : notif['type'] == 'completado' ? Colors.lightBlueAccent : Colors.amberAccent,
                          size: 32,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(notif['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        Text(notif['date'], style: TextStyle(color: Colors.white54, fontSize: 14)),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                          tooltip: 'Eliminar',
                          onPressed: () => _removeNotification(idx),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(notif['desc'], style: TextStyle(color: Colors.white70, fontSize: 16)),
                    if (notif['actions'].isNotEmpty) ...[
                      SizedBox(height: 16),
                      Row(
                        children: notif['actions'].map<Widget>((action) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: action == 'Aceptar' ? Colors.blueAccent : Colors.redAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                elevation: 8,
                                shadowColor: Colors.blueAccent,
                              ),
                              onPressed: () {},
                              child: Text(action, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
