class Artikel {

  final int id;
  final String name;
  final int? lieferantId;
  final int? menge;
  final String warenEinheit;
  final String warenTyp;
  final double preisProEinheit;
  final int? verdorbene;
  final int? rabat;

  Artikel ({required this.id,
        required this.name,
        this.lieferantId,
        this.menge,
        required this.warenEinheit,
        required this.warenTyp,
        required this.preisProEinheit,
        this.verdorbene,
        this.rabat});

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'] as int,
      name: json['name'] as String,
      lieferantId: json['lieferant']['id'] as int?,
      menge: json['menge'] as int?,
      warenEinheit: json['warenEinheit'] as String,
      warenTyp: json['warenTyp'] as String,
      preisProEinheit: json['preisProEinheit'] as double,
      verdorbene: json['verdorbene'] as int?,
      rabat: json['rabat'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lieferantId': lieferantId,
      'menge': menge,
      'warenEinheit': warenEinheit,
      'warenTyp': warenTyp,
      'preisProEinheit': preisProEinheit,
      'verdorbene': verdorbene,
      'rabat': rabat,
    };
  }
}