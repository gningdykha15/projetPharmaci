import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteDrugScreen extends StatefulWidget {
  @override
  _DeleteDrugScreenState createState() => _DeleteDrugScreenState();
}

class _DeleteDrugScreenState extends State<DeleteDrugScreen> {
  final TextEditingController _drugController = TextEditingController();

  // Fonction pour supprimer un médicament depuis l'API
  Future<void> deleteDrug() async {
    final String query = _drugController.text;

    // Assurez-vous que la saisie n'est pas vide
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer un nom ou un code-barres')),
      );
      return;
    }

    // Envoyer une requête DELETE à l'API
    final response = await http.delete(
      Uri.parse('http://tonapi.com/api/medicaments/$query'), // Remplace par ton URL réelle de l'API
      headers: {'Content-Type': 'application/json'},
    );

    // Vérifier si la suppression a réussi
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Médicament supprimé avec succès !')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la suppression du médicament.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supprimer un Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _drugController,
              decoration: InputDecoration(
                labelText: 'Nom du médicament ou Code-barres du médicament',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                deleteDrug(); // Appeler la fonction pour supprimer le médicament
              },
              child: Text(
                'Supprimer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
