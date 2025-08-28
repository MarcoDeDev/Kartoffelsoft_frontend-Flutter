// lib/screens/grosskunde_management_screen.dart

import 'package:flutter/material.dart';
import '../models/grosskunde.dart';
import '../services/grosskunde_service.dart';

class GrossKundeManagementScreen extends StatefulWidget {
  const GrossKundeManagementScreen({super.key});

  @override
  GrossKundeManagementScreenState createState() => GrossKundeManagementScreenState();
}

class GrossKundeManagementScreenState extends State<GrossKundeManagementScreen> {
  final GrossKundeService _grossKundeService = GrossKundeService();
  List<GrossKunde> _grossKundenListe = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _vornameController = TextEditingController();
  final TextEditingController _nachnameController = TextEditingController();
  final TextEditingController _firmaNameController = TextEditingController();
  final TextEditingController _strasseController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _ortController = TextEditingController();
  final TextEditingController _emailAdresseController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGrossKunden();
  }

  @override
  void dispose() {
    _vornameController.dispose();
    _nachnameController.dispose();
    _firmaNameController.dispose();
    _strasseController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _emailAdresseController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  Future<void> _loadGrossKunden() async {
    try {
      final grossKunden = await _grossKundeService.fetchGrosskunden();
      setState(() {
        _grossKundenListe = grossKunden;
      });
    } catch (e) {
      print('Fehler beim Laden der Großkunden: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Laden der Großkunden: $e')),
      );
    }
  }

  Future<void> _registerGrossKunde() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newGrossKunde = GrossKunde(
          id: 0,
          vorname: _vornameController.text,
          nachname: _nachnameController.text,
          firmaName: _firmaNameController.text.isEmpty ? null : _firmaNameController.text,
          strasse: _strasseController.text,
          plz: _plzController.text,
          ort: _ortController.text,
          emailAdresse: _emailAdresseController.text,
          telefon: _telefonController.text,
        );

        await _grossKundeService.createGrosskunde(newGrossKunde);
        _clearForm();
        await _loadGrossKunden();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Großkunde erfolgreich registriert!')),
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
    _firmaNameController.clear();
    _strasseController.clear();
    _plzController.clear();
    _ortController.clear();
    _emailAdresseController.clear();
    _telefonController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Neuen Großkunden hinzufügen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildRegistrationForm(),
          const SizedBox(height: 30),
          Text(
            'Alle Großkunden',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildGrossKundeTable(),
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
            validator: (value) => value!.isEmpty ? 'Bitte den Vornamen eingeben.' : null,
          ),

          TextFormField(
            controller: _nachnameController,
            decoration: const InputDecoration(labelText: 'Nachname'),
            validator: (value) => value!.isEmpty ? 'Bitte den Nachnamen eingeben.' : null,
          ),

          TextFormField(
            controller: _firmaNameController,
            decoration: const InputDecoration(labelText: 'Firmenname'),
          ),

          TextFormField(
            controller: _strasseController,
            decoration: const InputDecoration(labelText: 'Straße'),
            validator: (value) => value!.isEmpty ? 'Bitte die Straße eingeben.' : null,
          ),

          TextFormField(
            controller: _plzController,
            decoration: const InputDecoration(labelText: 'PLZ'),
            validator: (value) => value!.isEmpty ? 'Bitte die PLZ eingeben.' : null,
          ),

          TextFormField(
            controller: _ortController,
            decoration: const InputDecoration(labelText: 'Ort'),
            validator: (value) => value!.isEmpty ? 'Bitte den Ort eingeben.' : null,
          ),

          TextFormField(
            controller: _emailAdresseController,
            decoration: const InputDecoration(labelText: 'E-Mail-Adresse'),
            validator: (value) => value!.isEmpty ? 'Bitte die E-Mail-Adresse eingeben.' : null,
          ),

          TextFormField(
            controller: _telefonController,
            decoration: const InputDecoration(labelText: 'Telefon'),
            validator: (value) => value!.isEmpty ? 'Bitte die Telefonnummer eingeben.' : null,
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _registerGrossKunde,
            child: const Text('Registrieren'),
          ),

        ],
      ),
    );
  }

  Widget _buildGrossKundeTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(

        columns: const <DataColumn>[
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Vorname')),
          DataColumn(label: Text('Nachname')),
          DataColumn(label: Text('Firmenname')),
          DataColumn(label: Text('Straße')),
          DataColumn(label: Text('PLZ')),
          DataColumn(label: Text('Ort')),
          DataColumn(label: Text('E-Mail')),
          DataColumn(label: Text('Telefon')),
        ],
        rows: _grossKundenListe.map<DataRow>((grossKunde) {
          return DataRow(

            cells: <DataCell>[
              DataCell(Text(grossKunde.id.toString())),
              DataCell(Text(grossKunde.vorname)),
              DataCell(Text(grossKunde.nachname)),
              DataCell(Text(grossKunde.firmaName ?? '')),
              DataCell(Text(grossKunde.strasse)),
              DataCell(Text(grossKunde.plz)),
              DataCell(Text(grossKunde.ort)),
              DataCell(Text(grossKunde.emailAdresse)),
              DataCell(Text(grossKunde.telefon)),
            ],
          );
        }).toList(),
      ),
    );
  }
}