import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDrugScreen extends StatefulWidget {
  @override
  _AddDrugScreenState createState() => _AddDrugScreenState();
}

class _AddDrugScreenState extends State<AddDrugScreen> {
  // Controllers pour capturer les données saisies par l'utilisateur
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeBarreController = TextEditingController();
  final TextEditingController _fabricantController = TextEditingController();
  final TextEditingController _dateFabricationController = TextEditingController();
  final TextEditingController _dateExpirationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Fonction pour envoyer les données à l'API (Laravel)
  Future<void> addDrug() async {
    // Les données à envoyer à l'API
    final Map<String, dynamic> drugData = {
      'nom': _nameController.text,
      'code_barre': _codeBarreController.text,
      'fabricant': _fabricantController.text,
      'date_fabrication': _dateFabricationController.text,
      'date_expiration': _dateExpirationController.text,
      'description': _descriptionController.text,
    };

    // Envoyer une requête POST à l'API
    final response = await http.post(
      Uri.parse('http://tonapi.com/api/medicaments'), // Remplace avec l'URL correcte de ton API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(drugData),
    );

    // Vérifier si la requête a réussi
    if (response.statusCode == 201) {
      // Si la requête a réussi, afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Médicament ajouté avec succès !')),
      );
    } else {
      // En cas d'échec, afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de l\'ajout du médicament.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom du médicament'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _codeBarreController,
                decoration: InputDecoration(labelText: 'Code-barres du médicament'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _fabricantController,
                decoration: InputDecoration(labelText: 'Fabricant'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dateFabricationController,
                decoration: InputDecoration(labelText: 'Date de fabrication'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dateExpirationController,
                decoration: InputDecoration(labelText: 'Date d\'expiration'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addDrug(); // Appeler la fonction pour ajouter le médicament
                },
                child: Text(
                  'Ajouter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
