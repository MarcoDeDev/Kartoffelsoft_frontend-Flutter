import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/TeilDerLieferung.dart';

class TeilDerLieferungService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/teilderlieferung';


  Future<List<TeilDerLieferung>> fetchTeilDerLieferungen() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> teilDerLieferungenJson = json.decode(response.body);
      return teilDerLieferungenJson.map((json) => TeilDerLieferung.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load TeilDerLieferungn');
    }
  }

  Future<TeilDerLieferung> fetchTeilDerLieferungById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return TeilDerLieferung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load TeilDerLieferung');
    }
  }

  Future<TeilDerLieferung> createTeilDerLieferung(TeilDerLieferung teilDerLieferung) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(teilDerLieferung.toJson()),
    );

    if (response.statusCode == 201) {
      return TeilDerLieferung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create TeilDerLieferung');
    }
  }

  Future<void> deleteTeilDerLieferung(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete TeilDerLieferung');
    }
  }

}