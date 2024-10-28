// lib/models/medicament.dart

class Medicament {
  final String id;
  final String nom;
  final DateTime dateExpiration; // Correction ici
  final String fabricant;
  final String description;
  final String medicamentCode;
  final String notice;
  final String codeBarre;

  Medicament({
    required this.id,
    required this.nom,
    required this.dateExpiration, // Ajout du paramètre dateExpiration
    required this.fabricant,
    required this.description,
    required this.medicamentCode,
    required this.notice,
    required this.codeBarre,
  });

  // Factory pour créer un médicament à partir de JSON
  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json['id'],
      nom: json['nom'],
      dateExpiration: DateTime.parse(json['date_expiration']), // Conversion en DateTime
      fabricant: json['fabricant'],
      description: json['description'],
      medicamentCode: json['medicament_code'], // Correction ici (nom du champ JSON)
      notice: json['notice'],
      codeBarre: json['code_barre'],
    );
  }
}
