import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  RegisterScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajoute des marges horizontales globales
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Assurez-vous que le chemin est correct
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Confirmer mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Logique d'inscription fictive
                bool admin = false; // Remplacez par votre logique d'inscription
                onAuthenticated(admin); // Appelle le callback pour informer l'authentification
              },
              child: Text(
                'S\'inscrire',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            TextButton(
              onPressed: () {
                // Rediriger vers la page de connexion si nécessaire
                Navigator.of(context).pop(); // Retour à l'écran précédent (LoginScreen)
              },
              child: Text('Déjà inscrit ? Connexion ici',
                style: TextStyle(color: Colors.white),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
