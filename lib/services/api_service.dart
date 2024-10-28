// lib/services/api_service.dart

import 'dart:convert'; // Décommenté pour pouvoir utiliser json.decode
import 'package:http/http.dart' as http;
import '../models/medicament.dart';

class ApiService {
  Future<List<Medicament>> fetchMedicaments() async {
    try {
      final response = await http.get(Uri.parse('http://tonapi.com/api/medicaments'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Medicament.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load médicaments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch medications: $e');
    }
  }
}
