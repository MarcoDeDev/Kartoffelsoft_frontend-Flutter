import '../enums/waren_einheit.dart';
import '../enums/waren_typ.dart';

class Artikel {

  final int? id;
  final String name;
  final int? lieferantId;
  final int? menge;
  final WarenEinheit warenEinheit;
  final WarenTyp warenTyp;
  final double preisProEinheit;
  final int? verdorbene;
  final int? rabat;

  Artikel ({
        this.id,
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
      id: json['id'] as int?,
      name: json['name'] as String,
      lieferantId: json['lieferantId'] as int?,
      menge: json['menge'] as int?,
      warenEinheit: WarenEinheit.values.firstWhere((e) => e.name == json['warenEinheit']),
      warenTyp: WarenTyp.values.firstWhere((e) => e.name ==json['warenTyp']),
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
      'warenEinheit': warenEinheit.toString().split('.').last,
      'warenTyp': warenTyp.toString().split('.').last,
      'preisProEinheit': preisProEinheit,
      'verdorbene': verdorbene,
      'rabat': rabat,
    };
  }
}