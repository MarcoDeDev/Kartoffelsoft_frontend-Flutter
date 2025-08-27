// lib/screens/register_screen.dart

import 'package:flutter/material.dart';

import '../models/mitarbeiter.dart';
import '../services/mitarbeiter_service.dart';
import '../enums/role.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});


  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _abteilungIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedRole;

  final MitarbeiterService _mitarbeiterService = MitarbeiterService();

  void _register() async{
    if (_formKey.currentState!.validate()) {
      try {
        final vorname = _vornameController.text;
        final nachname = _nachnameController.text;
        final abteilungId = int.parse(_abteilungIdController.text);
        final password = _passwordController.text;
        final username = _usernameController.text;

        final Map<String, dynamic> requestBody = {
          'vorname': vorname,
          'nachname': nachname,
          'username': username,
          'password': password,
          'role': _selectedRole,
          'abteilung': {
            'id': abteilungId,
          },
        };

        await _mitarbeiterService.createMitarbeiter(requestBody);
        print('Registrierung erfolgreich');

        // Optional: Zeige eine Erfolgsmeldung an oder lösche die Felder
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mitarbeiter erfolgreich registriert!')),
        );

        // Leere die Formularfelder nach erfolgreicher Registrierung
        _vornameController.clear();
        _nachnameController.clear();
        _abteilungIdController.clear();
        _usernameController.clear();
        _passwordController.clear();
        setState(() {
          _selectedRole = null;
        });

      } catch (e) {
        print('Registrierung fehlgeschlagen: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrierung fehlgeschlagen: $e')),
        );


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

    return SingleChildScrollView( // SingleChildScrollView, um Scrollen zu ermöglichen

      child: Padding(
        padding: const EdgeInsets.all(16.00),

        child: Form(
          key: _formKey,
          child: Column(
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

              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Rolle'),
                value: _selectedRole,
                items: Role.values.map((role) {
                  return DropdownMenuItem<String>(
                    value: role.name,
                    child: Text(role.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                validator: (value) => value == null ? 'Bitte eine Rolle auswählen.' : null,
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