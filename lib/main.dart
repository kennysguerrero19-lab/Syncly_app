import 'package:flutter/material.dart';
import 'pantallas/splash.dart'; // Importa la pantalla de animación
import 'pantallas/register.dart';
import 'pantallas/project_details.dart';
import 'pantallas/login.dart';
import 'pantallas/projects.dart';
import 'pantallas/create_project.dart';
import 'pantallas/collaborators.dart';
import 'pantallas/messages.dart';
import 'pantallas/chat.dart';
import 'pantallas/notifications.dart';
import 'pantallas/settings.dart';
import 'pantallas/profile.dart';
import 'pantallas/privacy.dart';
import 'pantallas/help_center.dart';
import 'pantallas/support_chat.dart';

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
  '/privacy': (context) => BeautifulPrivacyScreen(),
  '/help_center': (context) => BeautifulHelpCenterScreen(),
  '/support_chat': (context) => BeautifulSupportChatScreen(),
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
    return WillPopScope(
      onWillPop: () async {
        // If there is a route to pop, allow it (e.g. pushed screens)
        if (Navigator.canPop(context)) return true;
        // If we're not on the first tab, go to the first tab instead of exiting/blank
        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
          return false; // don't pop the navigator
        }
        // Otherwise allow default behavior (may close the app)
        return true;
      },
      child: Scaffold(
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
      ),
    );
  }
}
