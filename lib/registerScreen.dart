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
              'images/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale entre les champs
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
                // Assume registration logic here
                bool admin = false; // Placeholder logic
                onAuthenticated(admin);
              },
              child: Text(
                'S\'inscrire',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
