import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddDrugScreen extends StatefulWidget {
  @override
  _AddDrugScreenState createState() => _AddDrugScreenState();
}

class _AddDrugScreenState extends State<AddDrugScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fabricantController = TextEditingController();
  final TextEditingController _dateExpirationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false; // Variable pour suivre l'état de chargement

  Future<void> addDrug() async {
    setState(() {
      _isLoading = true; // Activer le chargement
    });

    final Map<String, dynamic> drugData = {
      'nom': _nameController.text,
      'fabricant': _fabricantController.text,
      'date_expiration': _dateExpirationController.text,
      'description': _descriptionController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/medicaments/create'), // Remplace avec l'URL correcte de ton API
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(drugData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Médicament ajouté avec succès !')),
        );
        // Réinitialiser les champs après ajout réussi
        _nameController.clear();
        _fabricantController.clear();
        _dateExpirationController.clear();
        _descriptionController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'ajout du médicament.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite.')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Désactiver le chargement
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Médicament', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Icon(Icons.arrow_back, color: Colors.white), // Icône flèche en vert
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Veuillez remplir les informations suivantes :',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                SizedBox(height: 20),
                _buildTextField(_nameController, 'Nom du médicament'),
                SizedBox(height: 20),
                _buildTextField(_fabricantController, 'Fabricant'),
                SizedBox(height: 20),
                _buildTextField(_dateExpirationController, 'Date d\'expiration (YYYY-MM-DD)'),
                SizedBox(height: 20),
                _buildTextField(_descriptionController, 'Description'),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : () => addDrug(),
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.green, // Arrière-plan vert pour le bouton

                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.green)
                        : Text('Ajouter', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green), // Couleur verte pour le contour
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green), // Couleur verte pour le contour
        ),
      ),
      style: TextStyle(color: Colors.green),
    );
  }
}
