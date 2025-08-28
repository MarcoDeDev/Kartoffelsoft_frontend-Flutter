import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artikel.dart';

class ArtikelService {

  final String _baseUrl = 'http://localhost:8080/api/artikel';


  Future<List<Artikel>> fetchArtikeln() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> artikelenJson = json.decode(response.body);
      return artikelenJson.map((json) => Artikel.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load artikelen');
    }
  }

  Future<Artikel> fetchArtikelById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Artikel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load artikel');
    }
  }

  Future<Artikel> createArtikel(Map<String, dynamic> artikelData) async {
    final response = await http.post(
      Uri.parse(('$_baseUrl/register')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artikelData),
    );

    if (response.statusCode == 201) {
      return Artikel.fromJson(json.decode(response.body));
    }else {
      print('Fehler beim Erstellen des Artikels: ${response.statusCode}, Body: ${response.body}');
      throw Exception('Failed to create artikel');
    }
  }

  Future<void> deleteArtikel(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete artikel');
    }
  }
}