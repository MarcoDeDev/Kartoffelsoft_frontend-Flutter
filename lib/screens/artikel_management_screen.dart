import 'package:flutter/material.dart';
import '../models/artikel.dart';
import '../models/lieferant.dart'; // WICHTIG: du brauchst diese Klasse
import '../services/artikel_service.dart';
import '../services/lieferant_service.dart'; // WICHTIG: du brauchst diesen Service
import '../enums/waren_einheit.dart';
import '../enums/waren_typ.dart';

class ArtikelManagementScreen extends StatefulWidget {
  const ArtikelManagementScreen({super.key});

  @override
  ArtikelManagementScreenState createState() => ArtikelManagementScreenState();
}

class ArtikelManagementScreenState extends State<ArtikelManagementScreen> {

  final ArtikelService _artikelService = ArtikelService();
  final LieferantService _lieferantService = LieferantService();
  List<Artikel> _artikelListe = [];
  List<Lieferant> _lieferantenListe = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mengeController = TextEditingController();
  final TextEditingController _preisProEinheitController = TextEditingController();
  final TextEditingController _verdorbeneController = TextEditingController();
  final TextEditingController _rabatController = TextEditingController();

  int? _selectedLieferantId;
  WarenEinheit? _selectedWarenEinheit;
  WarenTyp? _selectedWarenTyp;

  @override
  void initState() {
    super.initState();
    _loadArtikel();
    _loadLieferanten();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mengeController.dispose();
    _preisProEinheitController.dispose();
    _verdorbeneController.dispose();
    _rabatController.dispose();
    super.dispose();
  }

  Future<void> _loadArtikel() async {
    try {
      final artikel = await _artikelService.fetchArtikeln();
      setState(() {
        _artikelListe = artikel;
      });
    } catch (e) {
      print('Fehler beim Laden der Artikel: $e');
    }
  }

  Future<void> _loadLieferanten() async {
    try {
      final lieferanten = await _lieferantService.fetchLieferanten();
      setState(() {
        _lieferantenListe = lieferanten;
      });
    } catch (e) {
      print('Fehler beim Laden der Lieferanten: $e');
    }
  }

  Future<void> _registerArtikel() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Hier wird eine Map (JSON-Objekt) erstellt
        final Map<String, dynamic> artikelData = {
          'name': _nameController.text,
          'lieferantId': _selectedLieferantId,
          'menge': int.tryParse(_mengeController.text) ?? 0,
          'warenEinheit': _selectedWarenEinheit!.name,
          'warenTyp': _selectedWarenTyp!.name,
          'preisProEinheit': double.tryParse(_preisProEinheitController.text),
          'verdorbene': int.tryParse(_verdorbeneController.text) ?? 0,
          'rabat': int.tryParse(_rabatController.text) ?? 0,
        };

        await _artikelService.createArtikel(artikelData);
        _clearForm();
        await _loadArtikel();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Artikel erfolgreich registriert!')),
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
    _nameController.clear();
    _mengeController.clear();
    _preisProEinheitController.clear();
    _verdorbeneController.clear();
    _rabatController.clear();
    setState(() {
      _selectedLieferantId = null;
      _selectedWarenEinheit = null;
      _selectedWarenTyp = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Neuen Artikel hinzufügen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildRegistrationForm(),
          const SizedBox(height: 30),
          Text(
            'Alle Artikel',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildArtikelTable(),
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
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie den Namen ein.' : null,
          ),

          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: 'Lieferant'),
            value: _selectedLieferantId,
            items: _lieferantenListe.map((lieferant) {
              return DropdownMenuItem<int>(
                value: lieferant.id,
                child: Text(lieferant.firmaName),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedLieferantId = newValue;
              });
            },
          ),

          TextFormField(
            controller: _mengeController,
            decoration: const InputDecoration(labelText: 'Menge'),
            keyboardType: TextInputType.number,
          ),

          DropdownButtonFormField<WarenEinheit>(
            decoration: const InputDecoration(labelText: 'Waren Einheit'),
            value: _selectedWarenEinheit,
            items: WarenEinheit.values.map((einheit) {
              return DropdownMenuItem<WarenEinheit>(
                value: einheit,
                child: Text(einheit.name),
              );
            }).toList(),
            onChanged: (WarenEinheit? newValue) {
              setState(() {
                _selectedWarenEinheit = newValue;
              });
            },
            validator: (value) => value == null ? 'Bitte eine Einheit auswählen.' : null,
          ),

          DropdownButtonFormField<WarenTyp>(
            decoration: const InputDecoration(labelText: 'Waren Typ'),
            value: _selectedWarenTyp,
            items: WarenTyp.values.map((typ) {
              return DropdownMenuItem<WarenTyp>(
                value: typ,
                child: Text(typ.name),
              );
            }).toList(),
            onChanged: (WarenTyp? newValue) {
              setState(() {
                _selectedWarenTyp = newValue;
              });
            },
            validator: (value) => value == null ? 'Bitte einen Typ auswählen.' : null,
          ),

          TextFormField(
            controller: _preisProEinheitController,
            decoration: const InputDecoration(labelText: 'Preis pro Einheit (€)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Bitte einen Preis eingeben.';
              }
              final preis = double.tryParse(value);
              if (preis == null || preis <= 0) {
                return 'Bitte einen gültigen Preis eingeben.';
              }
              return null;
            },
          ),

          TextFormField(
            controller: _verdorbeneController,
            decoration: const InputDecoration(labelText: 'Verdorbene'),
            keyboardType: TextInputType.number,
          ),

          TextFormField(
            controller: _rabatController,
            decoration: const InputDecoration(labelText: 'Rabat (%)'),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _registerArtikel,
            child: const Text('Registrieren'),
          ),

          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _clearForm,
            child: const Text('Formular zurücksetzen'),
          ),
        ],
      ),
    );
  }

  Widget _buildArtikelTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Lieferant ID')),
          DataColumn(label: Text('Menge')),
          DataColumn(label: Text('Einheit')),
          DataColumn(label: Text('Typ')),
          DataColumn(label: Text('Preis pro Einheit (€)')),
          DataColumn(label: Text('Verdorbene')),
          DataColumn(label: Text('Rabat (%)')),
        ],
        rows: _artikelListe.map<DataRow>((artikel) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(artikel.id.toString())),
              DataCell(Text(artikel.name)),
              DataCell(Text(artikel.lieferantId?.toString() ?? 'N/A')),
              DataCell(Text(artikel.menge?.toString() ?? '0')),
              DataCell(Text(artikel.warenEinheit.name)),
              DataCell(Text(artikel.warenTyp.name)),
              DataCell(Text(artikel.preisProEinheit.toString())),
              DataCell(Text(artikel.verdorbene?.toString() ?? '0')),
              DataCell(Text(artikel.rabat?.toString() ?? '0')),
            ],
          );
        }).toList(),
      ),
    );
  }
}