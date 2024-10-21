import 'package:cloud_firestore/cloud_firestore.dart';

class VacationHistoryModel {
  String id;
  int year;
  String vestingPeriod;
  DateTime startDate;
  DateTime endDate;

  VacationHistoryModel({
    required this.id,
    required this.year,
    required this.vestingPeriod,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'vestingPeriod': vestingPeriod,
      'startDate': startDate,
      'endDate': endDate,
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
    );
  }
}
