import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatelessWidget {
  // Controller pour capturer la saisie dans le champ de texte
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche de Médicaments'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Entrez le nom ou le code du médicament',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String query = _searchController.text;
                if (query.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicamentListScreen(query: query),
                    ),
                  );
                }
              },
              child: Text(
                'Rechercher',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe représentant un médicament
class Medicament {
  final String nom;
  final DateTime dateExpiration;
  final String fabricant;
  final String description;
  final String medicamentCode;
  final String notice;
  final String codeBarre;

  Medicament({
    required this.nom,
    required this.dateExpiration,
    required this.codeBarre,
    required this.description,
    required this.medicamentCode,
    required this.fabricant,
    required this.notice,
  });

  // Factory pour créer un médicament à partir de JSON
  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      nom: json['nom'],
      codeBarre: json['code_barre'],
      description: json['description'],
      fabricant: json['fabricant'],
      dateExpiration: DateTime.parse(json['date_expiration']), // Utiliser DateTime pour les dates
      medicamentCode: json['medicament_code'],
      notice: json['notice'],
    );
  }
}

// Simuler l'écran des résultats de recherche
class MedicamentListScreen extends StatefulWidget {
  final String query;

  MedicamentListScreen({required this.query});

  @override
  _MedicamentListScreenState createState() => _MedicamentListScreenState();
}

class _MedicamentListScreenState extends State<MedicamentListScreen> {
  late Future<Medicament?> _medicament;

  @override
  void initState() {
    super.initState();
    // Charger les informations du médicament lors du chargement de l'écran
    _medicament = fetchMedicament(widget.query);
  }

  // Fonction pour récupérer les informations d'un médicament depuis l'API
  Future<Medicament?> fetchMedicament(String query) async {
    final response = await http.get(Uri.parse('http://tonapi.com/api/medicaments/$query'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Medicament.fromJson(json);
    } else {
      return null; // Gestion des erreurs
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultats pour "${widget.query}"'),
      ),
      body: FutureBuilder<Medicament?>(
        future: _medicament,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur de chargement'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Aucun médicament trouvé'));
          } else {
            Medicament medicament = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom : ${medicament.nom}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Code-barre : ${medicament.codeBarre}'),
                  SizedBox(height: 10),
                  Text('Description : ${medicament.description}'),
                  SizedBox(height: 10),
                  Text('Fabricant : ${medicament.fabricant}'),
                  SizedBox(height: 10),
                  Text('Date d\'expiration : ${medicament.dateExpiration.toLocal()}'.split(' ')[0]), // Afficher la date
                  SizedBox(height: 10),
                  Text('Notice : ${medicament.notice}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
