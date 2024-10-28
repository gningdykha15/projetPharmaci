import 'package:flutter/material.dart';
import 'package:projet/homeScreen.dart';
import 'package:projet/adminScreen.dart';
import 'package:projet/constant.dart';
import 'package:projet/models/api_response.dart';
import 'package:projet/services/user_service.dart';
import 'package:projet/loginScreen.dart';
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

  void _loadUserInfo() async {
    String token = await getToken(); // Récupère le token d'authentification

    if (token.isEmpty) {
      // Si le token est vide, redirige vers la page de connexion
      _navigateToLogin();
    } else {
      // Si le token existe, récupère les détails de l'utilisateur
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        User user = response.data as User;
        if (user.id == 9 && user.role == 'editor') {
          // Si l'utilisateur est un administrateur spécifique, redirige vers la page d'accueil admin
          _navigateToAdmin();
        } else {
          // Redirection vers la page d'accueil normale pour les autres utilisateurs
          _navigateToHome();
        }
      } else if (response.error == unauthorized) {
        // Si l'erreur est d'autorisation, redirige vers la page de connexion
        _navigateToLogin();
      } else {
        // Affiche un message d'erreur
        _showErrorMessage(response.error);
      }
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }

  void _navigateToAdmin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => AdminScreen()),
      (route) => false,
    );
  }

  void _showErrorMessage(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? somethingwentwrong),
    ));
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
