// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'screens/kasse_screen.dart';
import 'screens/lager_screen.dart';

void main() => runApp(MyApp());

// Future<void> testLogin() async {
//   final url = Uri.parse('http://localhost:8080/api/mitarbeiter/login');
//   final body = jsonEncode({
//     'username': 'admin',
//     'password': 'admin123',
//   });
//
//   try {
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );
//
//     print('Statuscode: ${response.statusCode}');
//     print('Body: ${response.body}');
//   } catch (e) {
//     print('Fehler: $e');
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartoffelsoft',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/kasse_screen': (context) => KasseScreen(),
        '/lager_screen': (context) => LagerScreen(),
      },
    );
  }
}