class GrossKunde {

  final int id;
  final String vorname;
  final String nachname;
  final String firmaName;
  final String strasse;
  final String plz;
  final String ort;
  final String emailAdresse;
  final String telefon;

  GrossKunde ({required this.id,
          required this.vorname,
          required this.nachname,
          required this.firmaName,
          required this.strasse,
          required this.plz,
          required this.ort,
          required this.emailAdresse,
          required this.telefon});

  factory GrossKunde.fromJson(Map<String, dynamic> json) {
    return GrossKunde(
        id: json['id'] as int,
        vorname: json['vorname'] as String,
        nachname: json['nachname'] as String,
        firmaName: json['firmaName'] as String,
        strasse: json['strasse'] as String,
        plz: json['plz'] as String,
        ort: json['ort'] as String,
        emailAdresse: json['emailAdresse'] as String,
        telefon: json['telefon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'firmaName': firmaName,
      'strasse': strasse,
      'plz': plz,
      'ort': ort,
      'emailAdresse': emailAdresse,
      'telefon': telefon,
    };
  }
}