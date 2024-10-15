import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  LoginScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Ajoute une marge horizontale globale
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale pour le champ
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Ajoute une marge verticale pour le champ
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                // Assume authentication logic here
                bool admin = true; // Placeholder logic
                onAuthenticated(admin);
              },
              child: Text(
                'Se connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextButton(
              onPressed: () {
                // Logic to recover password
              },
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}