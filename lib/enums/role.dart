// lib/enums/role.dart
enum Role {
  ADMIN,
  BUEROARBEITER,
  KASSIERER,
  LAGERARBEITER,
}

// Füge eine Erweiterung hinzu, um den Namen als String zu bekommen
extension RoleExtension on Role {
  String get name {
    return this.toString().split('.').last;
  }
}