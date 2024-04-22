import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';

class AgentModel {
  int id;
  String name;
  BondTypeEnum bondType;
  String unit;
  String vacationMonth;
  String? phone;
  DateTime? startVacation;
  DateTime? endVacation;
  String? observations;

  AgentModel({
    required this.id,
    required this.name,
    required this.bondType,
    required this.unit,
    required this.vacationMonth,
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
      'startVacation': startVacation?.toIso8601String,
      'endVacation': endVacation?.toIso8601String,
      'observations': observations,
    };
  }

  factory AgentModel.fromMap(Map<String, dynamic> map) {
    return AgentModel(
      id: map['id'] as int,
      name: map['name'] as String,
      bondType: BondTypeEnum.fromString(map['bondType']),
      unit: map['unit'] as String,
      vacationMonth: map['vacationMonth'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      startVacation: DateTime.tryParse(map['startVacation'] ?? ''),
      endVacation: DateTime.tryParse(map['endVacation'] ?? ''),
      observations:
          map['observations'] != null ? map['observations'] as String : null,
    );
  }
}
