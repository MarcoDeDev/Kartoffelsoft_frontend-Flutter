import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/abteilung.dart';

class AbteilungService {

  final String _baseUrl = 'http://localhost:8080/api/abteilung';


  Future<List<Abteilung>> fetchAbteilungen() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> abteilungenJson = json.decode(response.body);
      return abteilungenJson.map((json) => Abteilung.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load abteilungen');
    }
  }


  Future<Abteilung> fetchAbteilungById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Abteilung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load abteilung');
    }
  }


  Future<Abteilung> createAbteilung(Abteilung abteilung) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(abteilung.toJson()),
    );

    if (response.statusCode == 201) {
      return Abteilung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create abteilung');
    }
  }


  Future<void> deleteAbteilung(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete abteilung');
    }
  }
}