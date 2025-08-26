// lib/screens/mitarbeiter_management_screen.dart

import 'package:flutter/material.dart';
import '../models/mitarbeiter.dart';
import '../services/mitarbeiter_service.dart';
import 'register_screen.dart'; // Importiere die angepasste Registrierungsseite

class MitarbeiterManagementScreen extends StatefulWidget {
  @override
  MitarbeiterManagementScreenState createState() => MitarbeiterManagementScreenState();
}

class MitarbeiterManagementScreenState extends State<MitarbeiterManagementScreen> {
  final MitarbeiterService _mitarbeiterService = MitarbeiterService();
  List<Mitarbeiter> _mitarbeiterListe = [];

  @override
  void initState() {
    super.initState();
    _loadMitarbeiter();
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
          SizedBox(height: 10),
          RegisterScreen(), // Das Formular für die Registrierung

          SizedBox(height: 30),

          // Überschrift für die Mitarbeiterliste
          Text(
            'Alle Mitarbeiter',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 10),
          // Tabelle zur Anzeige der Mitarbeiter
          _buildMitarbeiterTable(),
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