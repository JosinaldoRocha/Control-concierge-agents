import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/vacation_model.dart';

class AgentModel {
  String id;
  String name;
  BondTypeEnum bondType;
  String unit;
  String workShift;
  bool isDiarist;
  DateTime referenceDate;
  List<DateTime> workScale;
  String? phone;
  String? observations;
  String? imageUrl;
  VacationModel? vacation;

  AgentModel({
    required this.id,
    required this.name,
    required this.bondType,
    required this.unit,
    required this.workShift,
    required this.isDiarist,
    required this.referenceDate,
    required this.workScale,
    this.phone,
    this.observations,
    this.imageUrl,
    this.vacation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bondType': bondType.text,
      'unit': unit,
      'workShift': workShift,
      'isDiarist': isDiarist,
      'referenceDate': referenceDate,
      'workScale': workScale.map((date) => Timestamp.fromDate(date)).toList(),
      'phone': phone,
      'observations': observations,
      'imageUrl': imageUrl,
      'vacation': vacation != null ? vacation!.toMap() : null,
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
      isDiarist: snapshot['isDiarist'] as bool,
      referenceDate: (snapshot['referenceDate'] as Timestamp).toDate(),
      workScale: (snapshot['workScale'] as List<dynamic>)
          .map((timestamp) => (timestamp as Timestamp).toDate())
          .toList(),
      phone: snapshot['phone'] != null ? snapshot['phone'] as String : null,
      observations: snapshot['observations'] != null
          ? snapshot['observations'] as String
          : null,
      imageUrl:
          snapshot['imageUrl'] != null ? snapshot['imageUrl'] as String : null,
      vacation: snapshot['vacation'] != null
          ? VacationModel.fromMap(snapshot['vacation'] as Map<String, dynamic>)
          : null,
    );
  }
}
