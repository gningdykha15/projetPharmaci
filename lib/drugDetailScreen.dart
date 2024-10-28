import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Écran principal avec une liste de médicaments
class DrugListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Médicaments'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Médicament 1'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DrugDetailScreen(drugId: '12345'), // ID d'exemple
                ),
              );
            },
          ),
          ListTile(
            title: Text('Médicament 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DrugDetailScreen(drugId: '67890'), // Autre ID d'exemple
                ),
              );
            },
          ),
          // Ajoutez d'autres médicaments si nécessaire
        ],
      ),
    );
  }
}

// Écran de détails du médicament (votre code existant)
class DrugDetailScreen extends StatefulWidget {
  final String drugId; // L'ID ou le code-barre du médicament

  DrugDetailScreen({required this.drugId});

  @override
  _DrugDetailScreenState createState() => _DrugDetailScreenState();
}

class _DrugDetailScreenState extends State<DrugDetailScreen> {
  // Variables pour stocker les détails du médicament
  String drugName = '';
  String expiryDate = '';
  String manufacturer = '';
  bool isAuthentic = false;
  bool isLoading = true; // Pour indiquer que les données sont en cours de chargement
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchDrugDetails(); // Appel de la fonction de récupération dès le chargement
  }

  // Fonction pour récupérer les détails du médicament depuis l'API
  Future<void> fetchDrugDetails() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/medicaments/${widget.drugId}'));

      if (response.statusCode == 200) {
        // Si la requête est réussie, on récupère et décode le JSON
        final data = jsonDecode(response.body);

        setState(() {
          drugName = data['nom'];
          expiryDate = data['date_expiration'];
          manufacturer = data['fabricant'];
          isAuthentic = data['isAuthentic'];
          isLoading = false; // Fin du chargement
        });
      } else {
        // Gestion des erreurs de réponse
        setState(() {
          errorMessage = 'Échec de récupération des détails du médicament.';
          isLoading = false;
        });
      }
    } catch (e) {
      // Gestion des erreurs réseau ou JSON
      setState(() {
        errorMessage = 'Erreur : ${e.toString()}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Médicament'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Flèche de retour
          onPressed: () {
            Navigator.pop(context); // Navigue en arrière
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Loader pendant la récupération des données
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage)) // Affichage du message d'erreur
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom : $drugName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date d\'expiration : $expiryDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Fabricant : $manufacturer', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              isAuthentic ? 'Authentique' : 'Contrefait',
              style: TextStyle(
                fontSize: 18,
                color: isAuthentic ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
