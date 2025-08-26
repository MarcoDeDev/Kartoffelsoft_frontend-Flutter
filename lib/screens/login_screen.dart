// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../services/mitarbeiter_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  // Controller für die Textfelder
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final MitarbeiterService _mitarbeiterService = MitarbeiterService();

  // Funktion für die Anmelde-Logik
  void _login() async{

    if (_formKey.currentState!.validate()) {
      try {
        final username = _usernameController.text;
        final password = _passwordController.text;

        await _mitarbeiterService.loginMitarbeiter(username, password);

        // TODO: Navigiere zur Hauptseite bei Erfolg
        print('Login erfolgreich');
      }
      catch (e) {
        print('Login fehlgeschlagen: $e');
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Login'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Benutzername',),
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Benutzernamen ein.' : null,
              ),

              TextFormField(
                controller: _passwordController,
                obscureText: true, // Versteckt das eingegebene Passwort
                decoration: InputDecoration(labelText: 'Passwort',),
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihr Passwort ein.' : null,
              ),

              SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: _login,
                child: Text('Anmelden'),
              ),

              // TextButton(
              //   onPressed: () {
              //     // Navigiert zur Registrierungsseite über den benannten Pfad
              //     Navigator.pushNamed(context, '/register');
              //   },
              //   child: Text('Neu hier? Registrieren'),
              // ),

            ],
          ),
        ),
      ),
    );
  }
}

