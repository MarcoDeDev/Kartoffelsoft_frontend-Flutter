import 'package:flutter/material.dart';
import '../models/abteilung.dart';
import '../services/abteilung_service.dart';

class AbteilungManagementScreen extends StatefulWidget {
  const AbteilungManagementScreen({super.key});

  @override
  AbteilungManagementScreenState createState() => AbteilungManagementScreenState();
}

class AbteilungManagementScreenState extends State<AbteilungManagementScreen> {

  final AbteilungService _abteilungService = AbteilungService();
  List<Abteilung> _abteilungListe = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _abteilungNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAbteilungen();
  }

  @override
  void dispose() {
    _abteilungNameController.dispose();
    super.dispose();
  }

  Future<void> _loadAbteilungen() async {

    try {
      final abteilungen = await _abteilungService.fetchAbteilungen();
      setState(() {
        _abteilungListe = abteilungen;
      });

    } catch (e) {
      print('Fehler beim Laden der Abteilungen: $e');
    }
  }


  Future<void> _registerAbteilung() async {
    if (_formKey.currentState!.validate()) {

      try {
        final abteilung = Abteilung(abteilungName: _abteilungNameController.text);
        await _abteilungService.createAbteilung(abteilung);
        _clearForm();
        await _loadAbteilungen();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Abteilung erfolgreich registriert!')),
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
    _abteilungNameController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding: const EdgeInsets.all(16.0),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            'Neue Abteilung hinzufügen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildRegistrationForm(),

          const SizedBox(height: 30),

          Text(
            'Alle Abteilungen',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          _buildAbteilungTable(),
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
            controller: _abteilungNameController,
            decoration: const InputDecoration(labelText: 'Abteilungsname'),
            validator: (value) => value!.isEmpty ? 'Bitte geben Sie den Abteilungsnamen ein.' : null,
          ),

          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _registerAbteilung,
            child: const Text('Registrieren'),
          ),

        ],
      ),
    );
  }

  Widget _buildAbteilungTable() {

    return SingleChildScrollView(

      scrollDirection: Axis.horizontal,
      child: DataTable(

        columns: const <DataColumn>[
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Abteilungsname')),
        ],

        rows: _abteilungListe.map<DataRow>((abteilung) {
          return DataRow(
            cells: <DataCell>[

              DataCell(Text(abteilung.id.toString())),
              DataCell(Text(abteilung.abteilungName)),
            ],
          );
        }).toList(),

      ),
    );
  }
}