class TeilDerLieferung {

  final int id;
  final int artikelId;
  final int lieferungId;
  final int menge;
  final double preis;

  TeilDerLieferung ({
    required this.id,
    required this.artikelId,
    required this.lieferungId,
    required this.menge,
    required this.preis,
  });

  factory TeilDerLieferung.fromJson(Map<String, dynamic> json) {
    return TeilDerLieferung(
      id: json['id'] as int,
      artikelId: json['artikel']['id'] as int,
      lieferungId: json['lieferung']['id'] as int,
      menge: json['menge'] as int,
      preis: json['preis'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artikelId': artikelId,
      'lieferungId': lieferungId,
      'menge': menge,
      'preis': preis,
    };
  }
}