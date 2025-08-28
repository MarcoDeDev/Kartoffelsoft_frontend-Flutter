// lib/enums/warenTyp.dart

enum WarenTyp {
  EIGENE,
  KOMMISSION,
  FREMD,
}

// Fügt eine Erweiterung hinzu, um den Namen als String zu bekommen
extension WarenTypExtension on WarenTyp {
  String get name {
    return this.toString().split('.').last;
  }
}