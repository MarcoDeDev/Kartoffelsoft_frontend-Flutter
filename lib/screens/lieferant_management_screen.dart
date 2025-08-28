// lib/screens/lieferant_management_screen.dart

import 'package:flutter/material.dart';
import '../models/lieferant.dart';
import '../services/lieferant_service.dart';

class LieferantManagementScreen extends StatefulWidget {
  const LieferantManagementScreen({super.key});

  @override
  LieferantManagementScreenState createState() => LieferantManagementScreenState();
}

class LieferantManagementScreenState extends State<LieferantManagementScreen> {
  final LieferantService _lieferantService = LieferantService();
  List<Lieferant> _lieferantenListe = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firmaNameController = TextEditingController();
  final TextEditingController _strasseController = TextEditingController();
  final TextEditingController _plzController = TextEditingController();
  final TextEditingController _ortController = TextEditingController();
  final TextEditingController _emailAdresseController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLieferanten();
  }

  @override
  void dispose() {
    _firmaNameController.dispose();
    _strasseController.dispose();
    _plzController.dispose();
    _ortController.dispose();
    _emailAdresseController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  Future<void> _loadLieferanten() async {
    try {
      final lieferanten = await _lieferantService.fetchLieferanten();
      setState(() {
        _lieferantenListe = lieferanten;
      });
    } catch (e) {
      print('Fehler beim Laden der Lieferanten: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Laden der Lieferanten: $e')),
      );
    }
  }

  Future<void> _registerLieferant() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newLieferant = Lieferant(
          id: 0, // ID ist hier irrelevant und wird vom Backend überschrieben
          firmaName: _firmaNameController.text,
          strasse: _strasseController.text,
          plz: _plzController.text,
          ort: _ortController.text,
          emailAdresse: _emailAdresseController.text,
          telefon: _telefonController.text,
        );

        await _lieferantService.createLieferant(newLieferant);
        _clearForm();
        await _loadLieferanten();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lieferant erfolgreich registriert!')),
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
            'Neuen Lieferant hinzufügen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildRegistrationForm(),
          const SizedBox(height: 30),
          Text(
            'Alle Lieferanten',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildLieferantTable(),
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
            controller: _firmaNameController,
            decoration: const InputDecoration(labelText: 'Firmenname'),
            validator: (value) => value!.isEmpty ? 'Bitte den Firmennamen eingeben.' : null,
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
            onPressed: _registerLieferant,
            child: const Text('Registrieren'),
          ),
        ],
      ),
    );
  }

  Widget _buildLieferantTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Firmenname')),
          DataColumn(label: Text('Straße')),
          DataColumn(label: Text('PLZ')),
          DataColumn(label: Text('Ort')),
          DataColumn(label: Text('E-Mail')),
          DataColumn(label: Text('Telefon')),
        ],
        rows: _lieferantenListe.map<DataRow>((lieferant) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(lieferant.id.toString())),
              DataCell(Text(lieferant.firmaName)),
              DataCell(Text(lieferant.strasse)),
              DataCell(Text(lieferant.plz)),
              DataCell(Text(lieferant.ort)),
              DataCell(Text(lieferant.emailAdresse)),
              DataCell(Text(lieferant.telefon)),
            ],
          );
        }).toList(),
      ),
    );
  }
}