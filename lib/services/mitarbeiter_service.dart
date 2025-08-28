import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mitarbeiter.dart';

class MitarbeiterService {

  final String _baseUrl = 'http://localhost:8080/api/mitarbeiter';


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
      // Überprüfe, ob der Body nicht leer ist
      if (response.body.isNotEmpty) {
        return Mitarbeiter.fromJson(json.decode(response.body));
      } else {
        throw Exception('Serverantwort war erfolgreich, aber der Body war leer.');
      }
    } else {
      throw Exception('Login fehlgeschlagen. Statuscode: ${response.statusCode}');
    }
  }


  Future<Mitarbeiter> createMitarbeiter(Map<String, dynamic> mitarbeiterData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mitarbeiterData),
    );

    if (response.statusCode == 201) {
      return Mitarbeiter.fromJson(json.decode(response.body));
    }else {
      print('Fehler beim Erstellen des Mitarbeiters: ${response.statusCode}, Body: ${response.body}');
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