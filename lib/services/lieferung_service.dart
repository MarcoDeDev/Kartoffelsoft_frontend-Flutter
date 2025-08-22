import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lieferung.dart';

class LieferungService {

  final String _baseUrl = 'http://10.0.2.2:8080/api/lieferung';


  Future<List<Lieferung>> fetchLieferungen() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> lieferungenJson = json.decode(response.body);
      return lieferungenJson.map((json) => Lieferung.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load lieferungen');
    }
  }

  Future<Lieferung> fetchLieferungById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return Lieferung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to load lieferung');
    }
  }

  Future<Lieferung> createLieferung(Lieferung lieferung) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(lieferung.toJson()),
    );

    if (response.statusCode == 201) {
      return Lieferung.fromJson(json.decode(response.body));
    }else {
      throw Exception('Failed to create lieferung');
    }
  }

  Future<void> deleteLieferung(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete lieferung');
    }
  }


}