class Mitarbeiter {

  final int id;
  final String vorname;
  final String nachname;
  final int abteilungId;
  final String username;
  final String password;

  Mitarbeiter({
    required this.id,
    required this.vorname,
    required this.nachname,
    required this.abteilungId,
    required this.username,
    required this.password,
});

  factory Mitarbeiter.fromJson(Map<String, dynamic> json) {
    return Mitarbeiter(
        id: json['id'] as int,
        vorname: json['vorname'] as String,
        nachname: json['nachname'] as String,
        abteilungId: json['abteilungId'] as int,
        username: json['username'] as String,
        password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'abteilungId': abteilungId,
      'username': username,
      'password': password,
    };
  }
}