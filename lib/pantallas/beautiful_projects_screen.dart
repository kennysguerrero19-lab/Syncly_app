import 'package:flutter/material.dart';

class BeautifulProjectsScreen extends StatefulWidget {
  @override
  State<BeautifulProjectsScreen> createState() => _BeautifulProjectsScreenState();
}

class _BeautifulProjectsScreenState extends State<BeautifulProjectsScreen> {
  List<Map<String, dynamic>> projects = [
    {
      'title': 'App Educativa',
      'desc': 'Interfaz intuitiva para aprendizaje de lecciones.',
      'tags': ['UI/UX', 'Figma', 'Prototipado'],
      'color': Color(0xFF00E6E6),
      'progress': 0.7,
      'members': ['Ana', 'Carlos', 'Lucía'],
      'favorite': true,
    },
    {
      'title': 'Cortometraje Animado',
      'desc': 'Corto animado 2D sobre reciclaje.',
      'tags': ['Animación', 'Guión', 'Edición'],
      'color': Color(0xFFB36AFF),
      'progress': 0.4,
      'members': ['Lucía', 'Pedro'],
      'favorite': false,
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Si se regresa de crear proyecto con datos, agrégalo
    final newProject = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (newProject != null && !projects.any((p) => p['title'] == newProject['title'])) {
      setState(() {
        projects.insert(0, newProject);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Color(0xFF0A1A2F),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1A2F),
        elevation: 8,
        shadowColor: Colors.blueAccent,
        title: Text('Mis Proyectos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, letterSpacing: 1.1)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.blueAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.lightBlueAccent),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Nuevo Proyecto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/create_project');
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              projects.insert(0, result);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('¡Proyecto creado!', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, idx) {
            final project = projects[idx];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              elevation: 12,
              color: Color(0xFF142A47),
              shadowColor: Colors.blueAccent,
              margin: EdgeInsets.only(bottom: 20),
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: () {
                  Navigator.pushNamed(context, '/project_details');
                },
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.folder_special, color: Colors.blueAccent, size: 38),
                          SizedBox(width: 14),
                          Expanded(
                            child: Text(project['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1.1)),
                          ),
                          IconButton(
                            icon: Icon(project['favorite'] ? Icons.star : Icons.star_border, color: Colors.amberAccent),
                            onPressed: () {
                              setState(() {
                                project['favorite'] = !project['favorite'];
                              });
                            },
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.white70),
                            itemBuilder: (context) => [
                              PopupMenuItem(value: 'Editar', child: Text('Editar')),
                              PopupMenuItem(value: 'Eliminar', child: Text('Eliminar')),
                            ],
                            onSelected: (value) {
                              if (value == 'Eliminar') {
                                setState(() {
                                  projects.removeAt(idx);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Proyecto eliminado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                                );
                              } else if (value == 'Editar') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Función de edición próximamente', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(project['desc'], style: TextStyle(color: Colors.white70, fontSize: 16)),
                      SizedBox(height: 14),
                      Wrap(
                        spacing: 8,
                        children: List.generate(project['tags'].length, (i) {
                          return Chip(
                            label: Text(project['tags'][i], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            backgroundColor: Colors.blueAccent.withOpacity(0.7),
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Progreso:', style: TextStyle(color: Colors.white70)),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: project['progress'],
                              backgroundColor: Colors.white12,
                              color: Colors.blueAccent,
                              minHeight: 8,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('${(project['progress'] * 100).toInt()}%', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(Icons.group, color: Colors.lightBlueAccent, size: 24),
                          SizedBox(width: 8),
                          Text('Miembros:', style: TextStyle(color: Colors.white70)),
                          SizedBox(width: 8),
                          ...List.generate(project['members'].length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Chip(
                                label: Text(project['members'][i], style: TextStyle(color: Colors.white)),
                                backgroundColor: Color(0xFF142A47),
                                shape: StadiumBorder(side: BorderSide(color: Colors.blueAccent, width: 1)),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
