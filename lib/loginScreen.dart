import 'package:flutter/material.dart';
import 'constant.dart';

class LoginScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  LoginScreen({required this.onAuthenticated});

  void _showPasswordRecoveryDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Récupération de mot de passe'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Entrez votre adresse e-mail',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  // Ici, vous pouvez appeler votre API pour envoyer l'e-mail de récupération
                  // Exemple : await sendPasswordRecoveryEmail(email);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Un e-mail de récupération a été envoyé à $email'),
                  ));
                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Veuillez entrer une adresse e-mail valide.'),
                  ));
                }
              },
              child: Text('Envoyer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
              },
              child: Text('Annuler',
                
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                // Logique d'authentification fictive
                bool admin = true; // Remplacez par votre logique d'authentification
                onAuthenticated(admin); // Appelle la fonction onAuthenticated passée dans le constructeur
              },
              child: Text(
                'Se connecter',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            TextButton(
              onPressed: () {
                _showPasswordRecoveryDialog(context); // Ouvre la boîte de dialogue de récupération de mot de passe
              },
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.white), // Mettez en évidence
              ),
            ),
          ],
        ),
      ),
    );
  }
}
