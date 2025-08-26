// lib/main.dart

import 'package:flutter/material.dart';
import 'package:kartofelsoft_frontend/screens/login_screen.dart';
import 'package:kartofelsoft_frontend/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartoffelsoft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Definiert die Startroute
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        // Später hier die Hauptseite hinzufügen
        // '/home': (context) => MainScreen(),
      },
    );
  }
}