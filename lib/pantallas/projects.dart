import 'package:flutter/material.dart';

class BeautifulProjectsScreen extends StatefulWidget {
  @override
  State<BeautifulProjectsScreen> createState() => _BeautifulProjectsScreenState();
}

class _BeautifulProjectsScreenState extends State<BeautifulProjectsScreen> {
  Future<bool?> showConfirmDialog(String title, String content, String confirmText, String cancelText) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF142A47),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(content, style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            child: Text(cancelText, style: TextStyle(color: Colors.redAccent)),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: Text(confirmText, style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  Future<void> showEditProjectDialog(int idx) async {
    final project = projects[idx];
    final titleController = TextEditingController(text: project['title']);
    final descController = TextEditingController(text: project['desc']);
    final tagsController = TextEditingController(text: project['tags'].join(', '));
    double progress = project['progress'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF142A47),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text('Editar proyecto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF1B3556),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: descController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF1B3556),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 12),
                TextField(
                  controller: tagsController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Tags (separados por coma)',
                    labelStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color(0xFF1B3556),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(height: 12),
                Text('Progreso', style: TextStyle(color: Colors.white70)),
                Slider(
                  value: progress,
                  min: 0,
                  max: 1,
                  divisions: 100,
                  label: '${(progress * 100).toInt()}%',
                  activeColor: Colors.blueAccent,
                  inactiveColor: Colors.white24,
                  onChanged: (val) {
                    progress = val;
                    // Usar setState del dialog
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text('Guardar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  project['title'] = titleController.text.trim();
                  project['desc'] = descController.text.trim();
                  project['tags'] = tagsController.text.split(',').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
                  project['progress'] = progress;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Proyecto editado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueAccent),
                );
              },
            ),
          ],
        );
      },
    );
  }
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

  String searchText = '';
  List<Map<String, dynamic>> get filteredProjects {
    if (searchText.isEmpty) return projects;
    return projects.where((p) {
      final title = p['title']?.toString().toLowerCase() ?? '';
      final desc = p['desc']?.toString().toLowerCase() ?? '';
      return title.contains(searchText.toLowerCase()) || desc.contains(searchText.toLowerCase());
    }).toList();
  }

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
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar proyecto...',
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                filled: true,
                fillColor: Color(0xFF142A47),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: filteredProjects.isEmpty
                  ? Center(child: Text('No se encontraron proyectos', style: TextStyle(color: Colors.white54, fontSize: 18)))
                  : ListView.builder(
                      itemCount: filteredProjects.length,
                      itemBuilder: (context, idx) {
                        final project = filteredProjects[idx];
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
                                        onSelected: (value) async {
                                          if (value == 'Eliminar') {
                                            final confirm = await showConfirmDialog(
                                              '¿Eliminar proyecto?',
                                              '¿Estás seguro que quieres eliminar este proyecto? Esta acción no se puede deshacer.',
                                              'Eliminar',
                                              'Cancelar',
                                            );
                                            if (confirm == true) {
                                              setState(() {
                                                projects.removeAt(idx);
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Proyecto eliminado', style: TextStyle(color: Colors.white)), backgroundColor: Colors.redAccent),
                                              );
                                            }
                                          } else if (value == 'Editar') {
                                            final confirm = await showConfirmDialog(
                                              '¿Editar proyecto?',
                                              '¿Estás seguro que quieres editar este proyecto?',
                                              'Editar',
                                              'Cancelar',
                                            );
                                            if (confirm == true) {
                                              await showEditProjectDialog(idx);
                                            }
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
          ],
        ),
      ),
    );
  }
}
