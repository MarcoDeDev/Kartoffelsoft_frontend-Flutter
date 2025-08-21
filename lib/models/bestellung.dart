class Bestellung {

  final int id;
  final int? grossKundeId;
  final DateTime datum;
  final double gesamterPreis;
  final bool bezahlt;
  final String zahlungArt;
  final int? rabat;

  Bestellung ({required this.id,
          this.grossKundeId,
          required this.datum,
          required this.gesamterPreis,
          required this.bezahlt,
          required this.zahlungArt,
          this.rabat
  });

  factory Bestellung.fromJson(Map<String, dynamic> json) {
    return Bestellung(
      id: json['id'] as int,
      grossKundeId: json['grossKundeId'] as int,
      datum: DateTime.parse(json['datum'] as String),
      gesamterPreis: json['gesamterPreis'] as double,
      bezahlt: json['bezahlt'] as bool,
      zahlungArt: json['zahlungArt'] as String,
      rabat: json['rabat'] as int,
    );
  }
}