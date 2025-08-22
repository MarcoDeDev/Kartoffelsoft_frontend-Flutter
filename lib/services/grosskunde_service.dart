import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/grosskunde.dart';

class GrossKundeService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/grosskunde';


  Future<List<GrossKunde>> fetchGrosskunden() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> grossKundenJson = json.decode(response.body);
      return grossKundenJson.map((json) => GrossKunde.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load GrossKunden');
    }
  }

  Future<GrossKunde> fetchGrosskundeById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return GrossKunde.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load GrossKunde');
    }
  }

  Future<GrossKunde> createGrosskunde(GrossKunde grossKunde) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(grossKunde.toJson()),
    );

    if (response.statusCode == 201) {
      return GrossKunde.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create GrossKunde');
    }
  }

  Future<void> deleteGrossKunde(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete GrossKunde');
    }
  }

}