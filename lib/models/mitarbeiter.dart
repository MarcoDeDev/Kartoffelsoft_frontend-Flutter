class Mitarbeiter {

  final int id;
  final String vorname;
  final String nachname;
  final int abteilungId;

  Mitarbeiter({
    required this.id,
    required this.vorname,
    required this.nachname,
    required this.abteilungId,
});

  factory Mitarbeiter.fromJson(Map<String, dynamic> json) {
    return Mitarbeiter(
        id: json['id'] as int,
        vorname: json['vorname'] as String,
        nachname: json['nachname'] as String,
        abteilungId: json['abteilungId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vorname': vorname,
      'nachname': nachname,
      'abteilungId': abteilungId,
    };
  }
}