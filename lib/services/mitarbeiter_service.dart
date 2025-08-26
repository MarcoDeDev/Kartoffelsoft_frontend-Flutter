import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mitarbeiter.dart';

class MitarbeiterService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/mitarbeiter';


  Future<List<Mitarbeiter>> fetchMitarbeitern() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> mitarbeiternJson = json.decode(response.body);
      return mitarbeiternJson.map((json) => Mitarbeiter.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load mitarbeiteren');
    }
  }

  Future<Mitarbeiter> fetchMitarbeiterById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Mitarbeiter.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load mitarbeiter');
    }
  }

  Future<Mitarbeiter> loginMitarbeiter(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Mitarbeiter.fromJson(json.decode(response.body));
    }else {
      throw Exception('Login fehlgeschlagen. Bitte überprüfen Sie die Anmeldedaten.');
    }
  }


  Future<Mitarbeiter> createMitarbeiter(Mitarbeiter mitarbeiter) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mitarbeiter.toJson()),
    );

    if (response.statusCode == 201) {
      return Mitarbeiter.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create mitarbeiter');
    }
  }

  Future<void> deleteMitarbeiter(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete mitarbeiter');
    }
  }


}