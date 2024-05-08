import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';

class AgentModel {
  String id;
  String name;
  BondTypeEnum bondType;
  String unit;
  String workShift;
  DateTime? vacationPay;
  String? vacationMonth;
  String? phone;
  DateTime? startVacation;
  DateTime? endVacation;
  String? observations;

  AgentModel({
    required this.id,
    required this.name,
    required this.bondType,
    required this.unit,
    required this.workShift,
    this.vacationPay,
    this.vacationMonth,
    this.phone,
    this.startVacation,
    this.endVacation,
    this.observations,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bondType': bondType.text,
      'unit': unit,
      'workShift': workShift,
      'vacationPay': vacationPay,
      'vacationMonth': vacationMonth,
      'phone': phone,
      'startVacation': startVacation,
      'endVacation': endVacation,
      'observations': observations,
    };
  }

  factory AgentModel.fromSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return AgentModel(
      id: snapshot.id,
      name: snapshot['name'] as String,
      bondType: BondTypeEnum.fromString(snapshot['bondType'] as String),
      unit: snapshot['unit'] as String,
      workShift: snapshot['workShift'] as String,
      vacationPay: snapshot['vacationPay'] != null
          ? (snapshot['vacationPay'] as Timestamp).toDate()
          : null,
      vacationMonth: snapshot['vacationMonth'] != null
          ? snapshot['vacationMonth'] as String
          : null,
      phone: snapshot['phone'] != null ? snapshot['phone'] as String : null,
      startVacation: snapshot['startVacation'] != null
          ? (snapshot['startVacation'] as Timestamp).toDate()
          : null,
      endVacation: snapshot['endVacation'] != null
          ? (snapshot['endVacation'] as Timestamp).toDate()
          : null,
      observations: snapshot['observations'] != null
          ? snapshot['observations'] as String
          : null,
    );
  }
}
