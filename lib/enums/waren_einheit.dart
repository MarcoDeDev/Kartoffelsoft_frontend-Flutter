// lib/enums/warenEinheit.dart

enum WarenEinheit {
  KISTE,
  KG,
  FLASCHEN,
  STUCK,
}

// Fügt eine Erweiterung hinzu, um den Namen als String zu bekommen
extension WarenEinheitExtension on WarenEinheit {
  String get name {
    return this.toString().split('.').last;
  }
}