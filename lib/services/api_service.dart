// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/medicament.dart';

class ApiService {
  Future<List<Medicament>> fetchMedicaments() async {
    final response = await http.get(Uri.parse('http://tonapi.com/api/medicaments'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Medicament.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load médicaments');
    }
  }
}
