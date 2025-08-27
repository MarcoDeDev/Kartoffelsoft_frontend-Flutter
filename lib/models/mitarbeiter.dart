import '../enums/role.dart';

class Mitarbeiter {

  final int id;
  final String vorname;
  final String nachname;
  final int abteilungId;
  final String username;
  final String password;
  final Role role;

  Mitarbeiter({
    required this.id,
    required this.vorname,
    required this.nachname,
    required this.abteilungId,
    required this.username,
    required this.password,
    required this.role,
});

  factory Mitarbeiter.fromJson(Map<String, dynamic> json) {

    return Mitarbeiter(
        id: json['id'] as int,
        vorname: json['vorname'] as String,
        nachname: json['nachname'] as String,
        abteilungId: json['abteilungId'] ?? json['abteilung']?['id'] as int,
        username: json['username'] as String,
        password: json['password'] as String,
        role: Role.values.firstWhere((e) => e.name == json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'abteilungId': abteilungId,
      'username': username,
      'password': password,
      'role': role.toString().split('.').last,
    };
  }
}