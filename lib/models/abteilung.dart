class Abteilung {

  final int? id;
  final String abteilungName;

  Abteilung ({
          this.id,
          required this.abteilungName,
  });

  factory Abteilung.fromJson(Map<String, dynamic> json) {
    return Abteilung(
      id: json['id'] as int?,
      abteilungName: json['abteilungName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abteilungName': abteilungName,
    };
  }
}

