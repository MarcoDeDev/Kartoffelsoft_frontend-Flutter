class Lieferung {

  final int id;
  final DateTime datum;
  final int lieferantId;
  final double gesamterPreis;

  Lieferung ({required this.id,
          required this.datum,
          required this.lieferantId,
          required this.gesamterPreis
  });

  factory Lieferung.fromJson(Map<String, dynamic> json) {
    return Lieferung(
        id: json['id'] as int,
        datum: DateTime.parse(json['datum'] as String),
        lieferantId: json['lieferantId'] as int,
        gesamterPreis: json['gesamterPreis'] as double,
    );
  }
}