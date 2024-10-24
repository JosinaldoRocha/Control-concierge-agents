import 'package:cloud_firestore/cloud_firestore.dart';

class VacationHistoryModel {
  String id;
  int year;
  String vestingPeriod;
  DateTime startDate;
  DateTime endDate;
  DateTime vacationExpiration;

  VacationHistoryModel({
    required this.id,
    required this.year,
    required this.vestingPeriod,
    required this.startDate,
    required this.endDate,
    required this.vacationExpiration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'vestingPeriod': vestingPeriod,
      'startDate': startDate,
      'endDate': endDate,
      'vacationExpiration': vacationExpiration,
    };
  }

  factory VacationHistoryModel.fromSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return VacationHistoryModel(
      id: snapshot.id,
      year: snapshot['year'] as int,
      vestingPeriod: snapshot['vestingPeriod'] as String,
      startDate: (snapshot['startDate'] as Timestamp).toDate(),
      endDate: (snapshot['endDate'] as Timestamp).toDate(),
      vacationExpiration:
          (snapshot['vacationExpiration'] as Timestamp).toDate(),
    );
  }
}
