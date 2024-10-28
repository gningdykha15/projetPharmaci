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
      Uri.parse('http://127.0.0.1:8000/medicaments/$barcode'), // Modifier l'URL selon l'API Laravel
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
        title: Text('Modifier un Médicament', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green, // Couleur de l'AppBar en vert
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_nameController, 'Nom du médicament'),
            SizedBox(height: 20),
            _buildTextField(_barcodeController, 'Code-barres du médicament'),
            SizedBox(height: 20),
            _buildTextField(_manufacturerController, 'Fabricant'),
            SizedBox(height: 20),
            _buildTextField(_manufactureDateController, 'Date de fabrication'),
            SizedBox(height: 20),
            _buildTextField(_expiryDateController, 'Date d\'expiration'),
            SizedBox(height: 20),
            _buildTextField(_descriptionController, 'Description'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  editDrug(); // Appelle la fonction pour modifier le médicament
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Arrière-plan vert pour le bouton

                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Modifier',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green), // Couleur verte pour le label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green), // Couleur verte pour le contour
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green), // Couleur verte pour le contour
        ),
      ),
      style: TextStyle(color: Colors.green), // Couleur verte pour le texte
    );
  }
}
