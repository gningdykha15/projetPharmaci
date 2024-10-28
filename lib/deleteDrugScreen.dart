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
      Uri.parse('http://127.0.0.1:8000/medicaments/$query'), // Remplace par ton URL réelle de l'API
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
        title: Text(
          'Supprimer un Médicament',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Flèche en blanc
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Nom ou Code-barres du médicament',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                // Réduction de la longueur du champ de saisie
                Container(
                  width: 300, // Longueur personnalisée
                  child: TextField(
                    controller: _drugController,
                    decoration: InputDecoration(
                      hintText: 'Entrer le nom ou code-barres',
                      hintStyle: TextStyle(color: Colors.green[300]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Couleur de fond du bouton en vert
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Réduction du padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: deleteDrug,
                  icon: Icon(Icons.delete, color: Colors.red), // Couleur de l'icône en blanc
                  label: Text(
                    'Supprimer',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    
                  ),
                   
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
