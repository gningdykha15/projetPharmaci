import 'package:flutter/material.dart';
class DeleteDrugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supprimer un  Médicament'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nom du médicament ou Code-barres du medicament'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to delete a drug
              },
              child: Text('Supprimer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
