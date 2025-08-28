// lib/screens/mitarbeiter_management_screen.dart

import 'package:flutter/material.dart';
import '../models/mitarbeiter.dart';
import '../services/mitarbeiter_service.dart';
import '../enums/role.dart';

class MitarbeiterManagementScreen extends StatefulWidget {
  const MitarbeiterManagementScreen({super.key});

  @override
  MitarbeiterManagementScreenState createState() => MitarbeiterManagementScreenState();
}

class MitarbeiterManagementScreenState extends State<MitarbeiterManagementScreen> {

  final MitarbeiterService _mitarbeiterService = MitarbeiterService();
  List<Mitarbeiter> _mitarbeiterListe = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _abteilungIdController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _loadMitarbeiter();
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _abteilungIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadMitarbeiter() async {
    try {
      final mitarbeiter = await _mitarbeiterService.fetchMitarbeitern();
      setState(() {
        _mitarbeiterListe = mitarbeiter;
      });
    } catch (e) {
      print('Fehler beim Laden der Mitarbeiter: $e');
    }
  }

  Future<void> _registerMitarbeiter() async {
    if (_formKey.currentState!.validate()) {

      try {
        final abteilungId = int.tryParse(_abteilungIdController.text);

        final Map<String, dynamic> mitarbeiterData = {
          'vorname': _vornameController.text,
          'nachname': _nachnameController.text,
          'abteilungId': abteilungId,
          'username': _usernameController.text,
          'password': _passwordController.text,
          'role': _selectedRole,
        };

        await _mitarbeiterService.createMitarbeiter(mitarbeiterData);
        _clearForm();
        await _loadMitarbeiter();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mitarbeiter erfolgreich registriert!')),
        );
      } catch (e) {
        print('Registrierung fehlgeschlagen: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrierung fehlgeschlagen: $e')),
        );
      }
    }
  }

  void _clearForm() {
    _vornameController.clear();
    _nachnameController.clear();
    _abteilungIdController.clear();
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _selectedRole = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Überschrift für die Registrierungsfunktion
          Text(
            'Neuen Mitarbeiter hinzufügen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildRegistrationForm(),

          const SizedBox(height: 30),

          // Überschrift für die Mitarbeiterliste
          Text(
            'Alle Mitarbeiter',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          // Tabelle zur Anzeige der Mitarbeiter
          _buildMitarbeiterTable(),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          TextFormField(
            controller: _vornameController,
            decoration: const InputDecoration(labelText: 'Vorname'),
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Vornamen ein.' : null,
          ),

          TextFormField(
            controller: _nachnameController,
            decoration: const InputDecoration(labelText: 'Nachname'),
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Nachnamen ein.' : null,
          ),

          TextFormField(
            controller: _abteilungIdController,
            decoration: const InputDecoration(labelText: 'Abteilungs-ID'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Bitte geben Sie Ihre Abteilungs-ID ein.';
              }
              final id = int.tryParse(value);
              if (id == null || id <= 0) {
                return 'Bitte geben Sie eine gültige Abteilungs-ID ein.';
              }
              return null;
            },
          ),

          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Benutzername'),
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihren Benutzernamen ein.' : null,
          ),

          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Passwort'),
            obscureText: true,
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie Ihr Passwort ein.' : null,
          ),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Rolle'),
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

          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _registerMitarbeiter,
            child: const Text('Registrieren'),
          ),

        ],
      ),
    );
  }

  Widget _buildMitarbeiterTable() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(

        columns: const <DataColumn>[
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Vorname')),
          DataColumn(label: Text('Nachname')),
          DataColumn(label: Text('Abteilungs-ID')),
          DataColumn(label: Text('Benutzername')),
        ],
        rows: _mitarbeiterListe.map<DataRow>((mitarbeiter) {

          return DataRow(

            cells: <DataCell>[
              DataCell(Text(mitarbeiter.id.toString())),
              DataCell(Text(mitarbeiter.vorname)),
              DataCell(Text(mitarbeiter.nachname)),
              DataCell(Text(mitarbeiter.abteilungId.toString())),
              DataCell(Text(mitarbeiter.username)),
            ],
          );
        }).toList(),
      ),
    );
  }
}