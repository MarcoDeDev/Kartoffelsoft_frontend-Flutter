import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artikel.dart';

class ArtikelService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/artikel';


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

  Future<Artikel> createArtikel(Artikel artikel) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(artikel.toJson()),
    );

    if (response.statusCode == 201) {
      return Artikel.fromJson(json.decode(response.body));
    }else {
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