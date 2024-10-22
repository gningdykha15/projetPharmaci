import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VerifyDrugScreen extends StatefulWidget {
  @override
  _VerifyDrugScreenState createState() => _VerifyDrugScreenState();
}

class _VerifyDrugScreenState extends State<VerifyDrugScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  String drugName = '';
  String expiryDate = '';
  String manufacturer = '';
  bool isAuthentic = false;
  bool isLoading = false; // Indique si les données sont en cours de chargement
  String errorMessage = '';

  // Fonction pour vérifier le médicament
  Future<void> verifyDrug(String barcode) async {
    setState(() {
      isLoading = true; // Démarrer le chargement
      errorMessage = ''; // Réinitialiser le message d'erreur
    });

    try {
      // Affichage du code-barres pour débogage
      print('Vérification du code-barres: $barcode');

      final response = await http.get(Uri.parse('http://tonapi.com/api/medicaments/$barcode'));

      print('Code de réponse: ${response.statusCode}'); // Affiche le code de réponse

      if (response.statusCode == 200) {
        // Si la requête est réussie, on récupère et décode le JSON
        final data = jsonDecode(response.body);
        print('Données récupérées : $data'); // Affichage des données récupérées

        final medicament = data['medicament']; // Ajustez cette ligne en fonction de la structure réelle de votre réponse
        setState(() {
          drugName = medicament['nom'];
          expiryDate = medicament['date_expiration'];
          manufacturer = medicament['fabricant'];
          isAuthentic = medicament['isAuthentic'];
          isLoading = false; // Fin du chargement
        });
      } else {
        setState(() {
          errorMessage = 'Médicament non trouvé.';
          isLoading = false;
        });
      }
    } catch (e) {
      // Gestion des erreurs réseau ou JSON
      print('Erreur lors de la vérification : ${e.toString()}'); // Affichage de l'erreur pour débogage
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
        title: Text('Vérifier le Médicament'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: 'Entrez le code-barres',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_barcodeController.text.isNotEmpty) {
                  // Appeler la fonction de vérification
                  verifyDrug(_barcodeController.text);
                } else {
                  setState(() {
                    errorMessage = 'Veuillez entrer un code-barres valide.';
                  });
                }
              },
              child: Text('Vérifier'),
            ),
            SizedBox(height: 16.0),
            isLoading
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
          ],
        ),
      ),
    );
  }
}
