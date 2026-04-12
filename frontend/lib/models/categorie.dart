class Categorie {
  final String id;
  final String label;
  final String svgIcon;

  const Categorie({
    required this.id,
    required this.label,
    required this.svgIcon,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id:      json['id'].toString(),
      label:   json['label'] ?? '',
      svgIcon: json['svgIcon'] ?? json['svg_icon'] ?? '',
    );
  }
}
