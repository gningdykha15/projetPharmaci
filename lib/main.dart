
import 'package:flutter/material.dart';
import 'loadingScreen.dart'; // Assurez-vous que ce fichier existe
// Assurez-vous que ce fichier existe
import 'addDrugScreen.dart'; // Assurez-vous que ce fichier existe
import 'deleteDrugScreen.dart'; // Assurez-vous que ce fichier existe
import 'editDrugScreen.dart'; // Assurez-vous que ce fichier existe
import 'verifyDrugScreen.dart'; // Assurez-vous que ce fichier existe
import 'drugDetailScreen.dart'; // Assurez-vous que ce fichier existe
import 'homeScreen.dart'; // Importez votre HomeScreen
import 'scannerScreen.dart'; // Importez votre ScannerScreen
import 'searchScreen.dart'; // Importez votre SearchScreen
import 'adminScreen.dart'; // Importez votre AdminScreen

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Définir la route initiale
      routes: {
       '/': (context) => Loading(), // Page de chargement
        '/home': (context) => HomeScreen(), // Page d'accueil
        '/scanner': (context) => ScannerScreen(), // Page de scanner
        '/search': (context) => SearchScreen(), // Page de recherche
        '/admin': (context) => AdminScreen(), // Page admin
      
        '/addDrug': (context) => AddDrugScreen(),
        '/editDrug': (context) => EditDrugScreen(),
        '/deleteDrug': (context) => DeleteDrugScreen(),
        '/verifyDrugScreen': (context) => VerifyDrugScreen(),
        '/drugDetailScreen': (context) => DrugDetailScreen(drugId: '',),
        // Ajoutez d'autres routes ici si nécessaire
      },
      title: 'Authentification Médicaments', // Titre de l'application
    
      
    );
  }
}

// loginRegisterHint
Row KLoginRegister(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text), // Utilisation de la variable text
      GestureDetector(
        child: Text(label, style: TextStyle(color: Colors.green)),
        onTap: () => onTap(),
      ) 
    ],
  );
}
