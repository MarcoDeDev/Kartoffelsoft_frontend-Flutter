class TeilDerBestellung {

  final int id;
  final int artikelId;
  final int bestellungId;
  final int menge;
  final double preis;

  TeilDerBestellung ({
    required this.id,
    required this.artikelId,
    required this.bestellungId,
    required this.menge,
    required this.preis,
  });

  factory TeilDerBestellung.fromJson(Map<String, dynamic> json) {
    return TeilDerBestellung(
      id: json['id'] as int,
      artikelId: json['artikelId'] as int,
      bestellungId: json['bestellungId'] as int,
      menge: json['menge'] as int,
      preis: json['preis'] as double,
    );
  }
}