import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(  // Utilisation de SingleChildScrollView pour éviter les débordements
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,  // Centrage horizontal
            children: [
              // Logo en haut du titre
              Image.asset(
                'assets/images/logo.png',
                height: 100,  // Taille fixe pour éviter les problèmes de mise en page
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),

              // Titre accrocheur
              Text(
                'Authentifiez vos Médicaments avec Confiance',
                style: TextStyle(
                  fontSize: 24,  // Taille fixe du texte
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Sous-titre
              Text(
                'Prévenez la vente de médicaments contrefaits en scannant les codes-barres.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // Présentation du fonctionnement
              Text(
                'Scannez le code-barres de votre médicament pour vérifier son authenticité instantanément.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),

              // Illustration avec images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/scann.png',
                        width: 80,  // Taille fixe
                        height: 80, // Taille fixe
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Scannez',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/chek.jpeg',
                        width: 80,  // Taille fixe
                        height: 80, // Taille fixe
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Vérifiez',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}