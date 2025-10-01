import 'package:flutter/material.dart';


// Controller to manage the list of projects and related actions
class ProjectsController extends ChangeNotifier {
  List<String> _projects = [];

  // Get the current list of projects
  List<String> get projects => _projects;

  // Add a new project by name
  void addProject(String name) {
    _projects.add(name);
    notifyListeners();
  }

  // Remove a project by its index
  void removeProject(int index) {
    _projects.removeAt(index);
    notifyListeners();
  }
}

// Controller to manage collaborators and related actions
class CollaboratorsController extends ChangeNotifier {
  List<String> _collaborators = [];

  // Get the current list of collaborators
  List<String> get collaborators => _collaborators;

  // Add a new collaborator by name
  void addCollaborator(String name) {
    _collaborators.add(name);
    notifyListeners();
  }

  // Remove a collaborator by its index
  void removeCollaborator(int index) {
    _collaborators.removeAt(index);
    notifyListeners();
  }
}

// Controller to manage messages and related actions
class MessagesController extends ChangeNotifier {
  List<String> _messages = [];

  // Get the current list of messages
  List<String> get messages => _messages;

  // Add a new message
  void addMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }

  // Remove a message by its index
  void removeMessage(int index) {
    _messages.removeAt(index);
    notifyListeners();
  }
}

// Controller to manage notifications and related actions
class NotificationsController extends ChangeNotifier {
  List<String> _notifications = [];

  // Get the current list of notifications
  List<String> get notifications => _notifications;

  // Add a new notification
  void addNotification(String notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  // Remove a notification by its index
  void removeNotification(int index) {
    _notifications.removeAt(index);
    notifyListeners();
  }
}

// Controller to manage user profile data and updates
class ProfileController extends ChangeNotifier {
  String _name = '';
  String _email = '';

  // Get the user's name
  String get name => _name;

  // Get the user's email
  String get email => _email;

  // Update the user's profile information
  void updateProfile(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }
}
