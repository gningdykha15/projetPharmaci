import 'package:flutter/material.dart';
class AuthScreen extends StatelessWidget {
  final Function(bool) onAuthenticated;

  AuthScreen({required this.onAuthenticated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Connexion',
                style: TextStyle(color: Colors.white,
                ),

              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}