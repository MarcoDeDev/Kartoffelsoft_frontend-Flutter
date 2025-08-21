class Abteilung {

  final int id;
  final String abteilungName;
  final String berechtigung;

  Abteilung ({required this.id,
          required this.abteilungName,
          required this.berechtigung
  });

  factory Abteilung.fromJson(Map<String, dynamic> json) {
    return Abteilung(
      id: json['id'] as int,
      abteilungName: json['abteilungName'] as String,
      berechtigung: json['berechtigung'] as String,
    );
  }
}

