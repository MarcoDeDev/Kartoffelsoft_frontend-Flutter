import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lieferant.dart';

class LieferantService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/lieferant';


  Future<List<Lieferant>> fetchLieferanten() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> lieferantenJson = json.decode(response.body);
      return lieferantenJson.map((json) => Lieferant.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load lieferanten');
    }
  }

  Future<Lieferant> fetchLieferantById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Lieferant.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load lieferant');
    }
  }

  Future<Lieferant> createLieferant(Lieferant lieferant) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(lieferant.toJson()),
    );

    if (response.statusCode == 201) {
      return Lieferant.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create lieferant');
    }
  }

  Future<void> deleteLieferant(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete lieferant');
    }
  }


}