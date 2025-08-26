// lib/screens/register_screen.dart

import 'package:flutter/material.dart';

import '../models/mitarbeiter.dart';
import '../services/mitarbeiter_service.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _abteilungIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final MitarbeiterService _mitarbeiterService = MitarbeiterService();

  void _register() async{

    if (_formKey.currentState!.validate()) {
      try {
        final vorname = _vornameController.text;
        final nachname = _nachnameController.text;
        final abteilungId = int.parse(_abteilungIdController.text);
        final password = _passwordController.text;
        final username = _usernameController.text;

        final Mitarbeiter mitarbeiter = Mitarbeiter(
          // 'id' wird vom Backend generiert
          id: 0,
          vorname: vorname,
          nachname: nachname,
          abteilungId: abteilungId,
          password: password,
          username: username,
        );

        await _mitarbeiterService.createMitarbeiter(mitarbeiter);

        // TODO: Navigiere zur Login-Seite bei Erfolg
        print('Registrierung erfolgreich');
      }
      catch (e) {
        print('Registrierung fehlgeschlagen: $e');
      }
    }
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _abteilungIdController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Padding(
        padding: const EdgeInsets.all(16.00),

        child: Form(
          key: _formKey,
          child: ListView( // ListView, um Scrollen zu ermöglichen
            children: [
              TextFormField(
                controller: _vornameController,
                decoration: InputDecoration(labelText: 'Vorname'),
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Vornamen ein.' : null,
              ),

              TextFormField(
                controller: _nachnameController,
                decoration: InputDecoration(labelText: 'Nachname'),
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Nachnamen ein.' : null,
              ),

              TextFormField(
                controller: _abteilungIdController,
                decoration: InputDecoration(labelText: 'Abteilungs-ID'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihre Abteilungs-ID ein.' : null,
              ),

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Benutzername'),
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Benutzernamen ein.' : null,
              ),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Passwort'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihr Passwort ein.' : null,
              ),

              SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Registrieren'),
                ),

            ]
          ),
        ),
      ),
    );
  }
}