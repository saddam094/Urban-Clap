class DocumentModel {
  final String idProof;
  final String skillCertificate;
  final Appointment? appointment;

  DocumentModel({
    required this.idProof,
    required this.skillCertificate,
    this.appointment,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      idProof: json['id_proof'],
      skillCertificate: json['skill_certificate'],
      appointment: (json['appointment'] is Map<String, dynamic>)
          ? Appointment.fromJson(json['appointment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_proof': idProof,
      'skill_certificate': skillCertificate,
      'appointment': appointment?.toJson() ?? "",
    };
  }
}

class Appointment {
  final String date;
  final String shift;
  final String skillTest;
  final String testCenter;
  final String time;
  final String updatedAt;

  Appointment({
    required this.date,
    required this.shift,
    required this.skillTest,
    required this.testCenter,
    required this.time,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date: json['date'],
      shift: json['shift'],
      skillTest: json['skill_test'],
      testCenter: json['testCenter'],
      time: json['time'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'shift': shift,
      'skill_test': skillTest,
      'testCenter': testCenter,
      'time': time,
      'updated_at': updatedAt,
    };
  }
}
