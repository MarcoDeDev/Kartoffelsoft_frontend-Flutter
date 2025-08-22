import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bestellung.dart';

class BestellungService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/bestellung';


  Future<List<Bestellung>> fetchBestellungen() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> bestellungenJson = json.decode(response.body);
      return bestellungenJson.map((json) => Bestellung.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load bestellungen');
    }
  }

  Future<Bestellung> fetchBestellungById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Bestellung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load bestellung');
    }
  }

  Future<Bestellung> createBestellung(Bestellung bestellung) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bestellung.toJson()),
    );

    if (response.statusCode == 201) {
      return Bestellung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create bestellung');
    }
  }

  Future<void> deleteBestellung(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete bestellung');
    }
  }


}