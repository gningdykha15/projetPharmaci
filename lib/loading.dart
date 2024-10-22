import 'package:flutter/material.dart';
import 'package:projet/homeScreen.dart';
import 'package:projet/adminScreen.dart';
import 'package:projet/constant.dart';
import 'package:projet/models/api_response.dart';
import 'package:projet/services/user_service.dart';
import 'package:projet/loginScreen.dart';
import 'package:projet/registerScreen.dart'; // Assurez-vous que l'import est correct
import '../models/user.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Appelle la méthode de chargement des infos utilisateur
  }

  // Fonction de callback pour gérer l'authentification
  void onAuthenticated(bool isAdmin) {
    if (isAdmin) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AdminScreen()),
            (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
      );
    }
  }

  void _loadUserInfo() async {
    String token = await getToken(); // Récupère le token d'authentification

    if (token.isEmpty) {
      // Si le token est vide, redirige vers la page de connexion
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(onAuthenticated: onAuthenticated),
        ),
            (route) => false,
      );
    } else {
      // Si le token existe, récupère les détails de l'utilisateur
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        User user = response.data as User;
        if (user.id == 9 && user.role == 'editor') {
          // Si l'utilisateur est un administrateur spécifique
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AdminScreen()),
                (route) => false,
          );
        } else {
          // Redirection vers la page d'accueil normale
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
          );
        }
      } else if (response.error == unauthorized) {
        // Si l'erreur est d'autorisation, redirige vers la page de connexion
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginScreen(onAuthenticated: onAuthenticated),
          ),
              (route) => false,
        );
      } else {
        // Affiche un message d'erreur
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response.error ?? somethingwentwrong),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
