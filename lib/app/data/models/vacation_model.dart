import 'package:cloud_firestore/cloud_firestore.dart';

class VacationModel {
  DateTime? vacationExpiration;
  DateTime? startVacation;
  DateTime? endVacation;
  String? vacationMonth;
  String? vestingPeriod;

  VacationModel({
    this.vacationExpiration,
    this.startVacation,
    this.endVacation,
    this.vacationMonth,
    this.vestingPeriod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vacationExpiration': vacationExpiration,
      'startVacation': startVacation,
      'endVacation': endVacation,
      'vacationMonth': vacationMonth,
      'vestingPeriod': vestingPeriod,
    };
  }

  factory VacationModel.fromMap(Map<String, dynamic> snapshot) {
    return VacationModel(
      vacationExpiration: snapshot['vacationExpiration'] != null
          ? (snapshot['vacationExpiration'] as Timestamp).toDate()
          : null,
      startVacation: snapshot['startVacation'] != null
          ? (snapshot['startVacation'] as Timestamp).toDate()
          : null,
      endVacation: snapshot['endVacation'] != null
          ? (snapshot['endVacation'] as Timestamp).toDate()
          : null,
      vacationMonth: snapshot['vacationMonth'] != null
          ? snapshot['vacationMonth'] as String
          : null,
      vestingPeriod: snapshot['vestingPeriod'] != null
          ? snapshot['vestingPeriod'] as String
          : null,
    );
  }
}
