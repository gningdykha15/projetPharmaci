import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditDrugScreen extends StatefulWidget {
  @override
  _EditDrugScreenState createState() => _EditDrugScreenState();
}

class _EditDrugScreenState extends State<EditDrugScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _manufactureDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Fonction pour modifier un médicament dans la base de données
  Future<void> editDrug() async {
    final String name = _nameController.text;
    final String barcode = _barcodeController.text;
    final String manufacturer = _manufacturerController.text;
    final String manufactureDate = _manufactureDateController.text;
    final String expiryDate = _expiryDateController.text;
    final String description = _descriptionController.text;

    // Vérification de champs vides
    if (name.isEmpty || barcode.isEmpty || manufacturer.isEmpty || manufactureDate.isEmpty || expiryDate.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    // Préparation des données à envoyer
    final Map<String, String> body = {
      'nom': name,
      'code_barre': barcode,
      'fabricant': manufacturer,
      'date_fabrication': manufactureDate,
      'date_expiration': expiryDate,
      'description': description,
    };

    // Requête PUT ou PATCH à l'API pour mettre à jour le médicament
    final response = await http.put(
      Uri.parse('http://tonapi.com/api/medicaments/$barcode'), // Modifier l'URL selon l'API Laravel
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    // Vérification du succès de la mise à jour
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Médicament modifié avec succès !')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la modification du médicament.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom du médicament'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(labelText: 'Code-barres du médicament'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _manufacturerController,
              decoration: InputDecoration(labelText: 'Fabricant'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _manufactureDateController,
              decoration: InputDecoration(labelText: 'Date de fabrication'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _expiryDateController,
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
                editDrug(); // Appelle la fonction pour modifier le médicament
              },
              child: Text(
                'Modifier',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
