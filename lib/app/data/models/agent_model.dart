import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';

class AgentModel {
  String id;
  String name;
  BondTypeEnum bondType;
  String unit;
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
      'bondType': bondType.name,
      'unit': unit,
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
