import 'package:flutter/material.dart';
class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - Gestion des Médicaments'),
        centerTitle: true,
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
              _buildActionTile(context, Icons.medical_services, 'Vérifier Médicament', '/verifyDrug'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pour afficher une tuile du tableau de bord
  Widget _buildDashboardTile(IconData icon, String title, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigation vers la page correspondante
          if (route.isNotEmpty) {
            Navigator.pushNamed;
          }
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

Widget _buildDashboardTile(IconData icon, String label, String count) {
  return Column(
    children: [
      Icon(icon, size: 40, color: Colors.green),
      SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      Text(count, style: TextStyle(fontSize: 16)),
    ],
  );
}

Widget _buildActionTile(BuildContext context, IconData icon, String label, String route) {
  return ListTile(
    leading: Icon(icon, size: 40, color: Colors.green),
    title: Text(label, style: TextStyle(fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}