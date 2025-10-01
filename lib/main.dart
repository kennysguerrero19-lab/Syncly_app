import 'package:flutter/material.dart';
import 'pantallas/beautiful_splash_screen.dart'; // Importa la pantalla de animación
import 'pantallas/beautiful_register_screen.dart';
import 'pantallas/beautiful_project_details_screen.dart';
import 'pantallas/beautiful_login_screen.dart';
import 'pantallas/beautiful_projects_screen.dart';
import 'pantallas/beautiful_create_project_screen.dart';
import 'pantallas/beautiful_collaborators_screen.dart';
import 'pantallas/beautiful_messages_screen.dart';
import 'pantallas/beautiful_chat_screen.dart';
import 'pantallas/beautiful_notifications_screen.dart';
import 'pantallas/beautiful_settings_screen.dart';
import 'pantallas/beautiful_profile_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Muestra la animación al iniciar
      routes: {
        '/splash': (context) => BeautifulSplashScreen(), // Ruta de la animación
        '/register': (context) => BeautifulRegisterScreen(),
        '/login': (context) => BeautifulLoginScreen(),
        '/home': (context) => MainNavigation(),
        '/projects': (context) => BeautifulProjectsScreen(),
        '/create_project': (context) => BeautifulCreateProjectScreen(),
        '/collaborators': (context) => BeautifulCollaboratorsScreen(),
        '/messages': (context) => BeautifulMessagesScreen(),
        '/chat': (context) => BeautifulChatScreen(),
        '/notifications': (context) => BeautifulNotificationsScreen(),
        '/settings': (context) => BeautifulSettingsScreen(),
        '/profile': (context) => BeautifulProfileScreen(),
        '/project_details': (context) => BeautifulProjectDetailsScreen(),
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    BeautifulProjectsScreen(),
    BeautifulCreateProjectScreen(),
    BeautifulCollaboratorsScreen(),
    BeautifulMessagesScreen(),
    BeautifulNotificationsScreen(),
    BeautifulSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF181818),
          border: Border(top: BorderSide(color: Color(0xFF222222), width: 1)),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFF181818),
          selectedItemColor: Color(0xFF00E6E6),
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Proyectos'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Crear'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Colaborar'),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mensajes'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Avisos'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
          ],
        ),
      ),
    );
  }
}