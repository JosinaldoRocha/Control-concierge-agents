import 'package:control_concierge_agents/app/data/enums/month_enum.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../data/enums/bond_type_enum.dart';

final unitList = [
  const DropDownValueModel(name: 'Esc. São João Batista', value: 1),
  const DropDownValueModel(name: 'Esc. Catarina Pimentel', value: 2),
  const DropDownValueModel(name: 'Esc. Raimundo Pires Chaves', value: 3),
  const DropDownValueModel(name: 'Esc. Joias de Cristo', value: 4),
  const DropDownValueModel(name: 'Esc. Dey Alves Pessoa', value: 5),
  const DropDownValueModel(name: 'Esc. Osvaldo Rodrigues da Costa', value: 6),
  const DropDownValueModel(name: 'Esc. Obra social madre Luiza', value: 7),
  const DropDownValueModel(name: 'Esc. Cantinho do saber', value: 8),
  const DropDownValueModel(name: 'Esc. Cantinho do saber - Anexo', value: 9),
  const DropDownValueModel(name: 'Esc. José Cesário da Silva', value: 10),
  const DropDownValueModel(name: 'Esc. Maria das Graças', value: 11),
  const DropDownValueModel(name: 'Esc. Raimundo Almeida Pimentel', value: 12),
  const DropDownValueModel(name: 'Esc. Viriato Correia', value: 13),
  const DropDownValueModel(name: 'Esc. Joanice Soares', value: 14),
  const DropDownValueModel(name: 'Esc. São Marcos', value: 15),
  const DropDownValueModel(name: 'Esc. Luzia Botelho', value: 16),
  const DropDownValueModel(name: 'Esc. Betânia', value: 17),
  const DropDownValueModel(name: 'Esc. João Barbosa', value: 18),
  const DropDownValueModel(name: 'Qdr José Neves de Oliveira', value: 19),
  const DropDownValueModel(name: 'Qdr Leonardo Reis de Carvalho', value: 20),
  const DropDownValueModel(name: 'Qdr Areninha', value: 21),
  const DropDownValueModel(
      name: 'Dpto de educação especial inclusiva', value: 20),
  const DropDownValueModel(name: 'Dpto Ferista', value: 21),
  const DropDownValueModel(name: 'Semed', value: 22),
];

final bondTypeList = [
  DropDownValueModel(
    name: BondTypeEnum.effective.text,
    value: BondTypeEnum.effective,
  ),
  DropDownValueModel(
    name: BondTypeEnum.contract.text,
    value: BondTypeEnum.contract,
  ),
];

final monthList = [
  DropDownValueModel(name: MonthEnum.january.text, value: MonthEnum.january),
  DropDownValueModel(name: MonthEnum.february.text, value: MonthEnum.february),
  DropDownValueModel(name: MonthEnum.march.text, value: MonthEnum.march),
  DropDownValueModel(name: MonthEnum.april.text, value: MonthEnum.april),
  DropDownValueModel(name: MonthEnum.may.text, value: MonthEnum.may),
  DropDownValueModel(name: MonthEnum.june.text, value: MonthEnum.june),
  DropDownValueModel(name: MonthEnum.july.text, value: MonthEnum.july),
  DropDownValueModel(name: MonthEnum.august.text, value: MonthEnum.august),
  DropDownValueModel(
    name: MonthEnum.september.text,
    value: MonthEnum.september,
  ),
  DropDownValueModel(name: MonthEnum.october.text, value: MonthEnum.october),
  DropDownValueModel(name: MonthEnum.november.text, value: MonthEnum.november),
  DropDownValueModel(name: MonthEnum.december.text, value: MonthEnum.december),
];
