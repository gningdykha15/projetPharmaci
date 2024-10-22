import 'package:flutter/material.dart';
import 'package:projet/services/user_service.dart';

import 'loginScreen.dart'; // Assurez-vous que ce fichier contient bien la bonne définition de login()

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Gestion des Médicaments'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              bool result = await logout();  // Assurez-vous que logout() renvoie bien un booléen
              if (result) {
                // Assurez-vous que login() est un widget de type page de connexion
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen(onAuthenticated: (bool result) {})),
                      (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tableau de bord
              Text(
                'Tableau de bord',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDashboardTile(Icons.medical_services, 'Médicaments Vérifiés', ''),
                  _buildDashboardTile(Icons.add, 'Médicaments Ajoutés', ''),
                  _buildDashboardTile(Icons.edit, 'Médicaments Modifiés', ''),
                  _buildDashboardTile(Icons.delete, 'Médicaments Supprimés', ''),
                  _buildDashboardTile(Icons.details, ' Details Médicaments ', ''),
                ],
              ),
              SizedBox(height: 20),

              // Actions
              Text(
                'Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildActionTile(context, Icons.add, 'Ajouter Médicament', '/addDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.edit, 'Modifier Médicament', '/editDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.delete, 'Supprimer Médicament', '/deleteDrug'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.medical_services, 'Vérifier Médicament', '/verifyDrugSreen'),
              SizedBox(height: 8),
              _buildActionTile(context, Icons.medical_services, 'Details Médicament', '/drugDetailScreen'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une tuile du tableau de bord
  Widget _buildDashboardTile(IconData icon, String title, String count) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigation vers la page correspondante
          // Si un chemin est défini, on peut l'utiliser ici
        },
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une tuile d'action
  Widget _buildActionTile(BuildContext context, IconData icon, String title, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 32),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
