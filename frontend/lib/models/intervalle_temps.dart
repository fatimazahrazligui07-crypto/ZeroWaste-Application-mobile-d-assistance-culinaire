// lib/models/intervalle_temps.dart

class IntervalleTemps {
  final int id;
  final String libelle;

  const IntervalleTemps({required this.id, required this.libelle});

  factory IntervalleTemps.fromJson(Map<String, dynamic> json) {
    return IntervalleTemps(
      id:      json['id'] as int,
      libelle: json['libelle'] as String,
    );
  }
}