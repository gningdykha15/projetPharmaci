
import 'package:flutter/material.dart';
class DrugDetailScreen extends StatelessWidget {
  final String drugName;
  final String expiryDate;
  final String manufacturer;
  final bool isAuthentic;

  DrugDetailScreen({
    required this.drugName,
    required this.expiryDate,
    required this.manufacturer,
    required this.isAuthentic,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Médicament'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom : $drugName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Date d\'expiration : $expiryDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Fabricant : $manufacturer', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              isAuthentic ? 'Authentique' : 'Contrefait',
              style: TextStyle(
                fontSize: 18,
                color: isAuthentic ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
