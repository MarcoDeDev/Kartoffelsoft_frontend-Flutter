class Lieferant {

  final int id;
  final String firmaName;
  final String strasse;
  final String plz;
  final String ort;
  final String emailAdresse;
  final String telefon;

  Lieferant ({
          required this.id,
          required this.firmaName,
          required this.strasse,
          required this.plz,
          required this.ort,
          required this.emailAdresse,
          required this.telefon
  });

  factory Lieferant.fromJson(Map<String, dynamic> json) {
    return Lieferant(
        id: json['id'] as int,
        firmaName: json['firmaName'] as String,
        strasse: json['strasse'] as String,
        plz: json['plz'] as String,
        ort: json['ort'] as String,
        emailAdresse: json['emailAdresse'] as String,
        telefon: json['telefon'] as String,
    );
  }
}