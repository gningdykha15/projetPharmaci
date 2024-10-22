// lib/medicament_list.dart

import 'package:flutter/material.dart';
import '../models/medicament.dart';
import '../services/api_service.dart';

class MedicamentList extends StatefulWidget {
  @override
  _MedicamentListState createState() => _MedicamentListState();
}

class _MedicamentListState extends State<MedicamentList> {
  late Future<List<Medicament>> futureMedicaments;

  @override
  void initState() {
    super.initState();
    futureMedicaments = ApiService().fetchMedicaments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des Médicaments')),
      body: FutureBuilder<List<Medicament>>(
        future: futureMedicaments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].nom),
                  subtitle: Text('Code-barre: ${snapshot.data![index].codeBarre}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
