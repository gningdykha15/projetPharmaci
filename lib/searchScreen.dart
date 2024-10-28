import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<String> medicaments = [
    'Paracétamol',
    'Ibuprofène',
    'Aspirine',
    'Amoxicilline',
    'Cétirizine',
    // Ajoutez d'autres médicaments ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche',
        style: TextStyle(color: Colors.white),
        ), // Titre de la page
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un médicament',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                // Logique de recherche ici
                // Utilisez la valeur entrée pour interroger votre base de données
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique pour la recherche ici
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Couleur verte pour le bouton
              ),
              child: Text('Rechercher'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: medicaments.length, // Utilisez le nombre de médicaments
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medicaments[index]), // Afficher les résultats de recherche
                    onTap: () {
                      // Logique pour afficher les détails du médicament
                      // Navigator.pushNamed(context, '/drugDetail');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
        currentIndex: 1, // Index de l'onglet "Recherche"
        selectedItemColor: Colors.green, // Couleur verte pour l'élément sélectionné
        unselectedItemColor: Colors.green, // Couleur pour les éléments non sélectionnés
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home'); // Naviguer vers Accueil
              break;
            case 1:
              // Reste sur la page de recherche
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/scanner'); // Naviguer vers Scanner
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/admin'); // Naviguer vers Admin
              break;
          }
        },
      ),
    );
  }
}
