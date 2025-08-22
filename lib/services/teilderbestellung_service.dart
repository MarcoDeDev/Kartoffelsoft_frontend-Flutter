import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teilDerBestellung.dart';

class TeilDerBestellungService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/teilderbestellung';


  Future<List<TeilDerBestellung>> fetchTeilDerBestellungen() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> teilDerBestellungenJson = json.decode(response.body);
      return teilDerBestellungenJson.map((json) => TeilDerBestellung.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load TeilDerBestellungn');
    }
  }

  Future<TeilDerBestellung> fetchTeilDerBestellungById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return TeilDerBestellung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load TeilDerBestellung');
    }
  }

  Future<TeilDerBestellung> createTeilDerBestellung(TeilDerBestellung teilDerBestellung) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(teilDerBestellung.toJson()),
    );

    if (response.statusCode == 201) {
      return TeilDerBestellung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create TeilDerBestellung');
    }
  }

  Future<void> deleteTeilDerBestellung(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete TeilDerBestellung');
    }
  }

}