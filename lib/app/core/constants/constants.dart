import 'package:control_concierge_agents/app/data/enums/agent_status_enum.dart';
import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/data/enums/month_enum.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../data/enums/bond_type_enum.dart';

final unitList = [
  const DropDownValueModel(name: 'Esc São João Batista', value: 1),
  const DropDownValueModel(name: 'Esc Catarina Pimentel', value: 2),
  const DropDownValueModel(name: 'Esc Raimundo Pires Chaves', value: 3),
  const DropDownValueModel(name: 'Esc Joias de Cristo', value: 4),
  const DropDownValueModel(name: 'Esc Dey Alves Pessoa', value: 5),
  const DropDownValueModel(name: 'Esc Osvaldo Rodrigues da Costa', value: 6),
  const DropDownValueModel(name: 'Esc Obra social madre Luiza', value: 7),
  const DropDownValueModel(name: 'Esc Cantinho do saber - Sede', value: 8),
  const DropDownValueModel(name: 'Esc Cantinho do saber - Anexo', value: 9),
  const DropDownValueModel(name: 'Esc José Cesário da Silva', value: 10),
  const DropDownValueModel(name: 'Esc Maria das Graças', value: 11),
  const DropDownValueModel(name: 'Esc Raimundo Almeida Pimentel', value: 12),
  const DropDownValueModel(name: 'Esc Viriato Correia', value: 13),
  const DropDownValueModel(name: 'Cr Joanice Soares', value: 14),
  const DropDownValueModel(name: 'Esc São Marcos', value: 15),
  const DropDownValueModel(name: 'Cr Luzia Botelho', value: 16),
  const DropDownValueModel(name: 'Esc Betânia', value: 17),
  const DropDownValueModel(name: 'Esc João Barbosa', value: 18),
  const DropDownValueModel(name: 'Qdr José Neves de Oliveira', value: 19),
  const DropDownValueModel(name: 'Qdr Leonardo Reis de Carvalho', value: 20),
  const DropDownValueModel(name: 'Dep Ferista', value: 21),
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

final agentStatusList = [
  DropDownValueModel(
    name: AgentStatus.isActive.text,
    value: AgentStatus.isActive,
  ),
  DropDownValueModel(
    name: AgentStatus.isOnLeave.text,
    value: AgentStatus.isOnLeave,
  ),
  DropDownValueModel(
    name: AgentStatus.isCertified.text,
    value: AgentStatus.isCertified,
  ),
  DropDownValueModel(
    name: AgentStatus.functiondeviation.text,
    value: AgentStatus.functiondeviation,
  ),
];

final workShiftList = [
  const DropDownValueModel(name: 'Diurno - 12/36h', value: 01),
  const DropDownValueModel(name: 'Diurno - seg à sex', value: 02),
  const DropDownValueModel(name: 'Noturno - 12/36h', value: 03),
  const DropDownValueModel(name: 'Noturno - seg à sex', value: 04),
  const DropDownValueModel(name: 'Noturno - EJA', value: 05),
  const DropDownValueModel(name: 'Dinâmico - Ferista', value: 06),
];

final filterList = [
  FilterType.bondType,
  FilterType.unit,
  FilterType.workShift,
  FilterType.vacationExpiration,
];

final listMonths = [
  DropDownValueModel(name: 'Janeiro', value: MonthEnum.january),
  DropDownValueModel(name: 'Fevereiro', value: MonthEnum.february),
  DropDownValueModel(name: 'Março', value: MonthEnum.march),
  DropDownValueModel(name: 'Abril', value: MonthEnum.april),
  DropDownValueModel(name: 'Maio', value: MonthEnum.may),
  DropDownValueModel(name: 'Junho', value: MonthEnum.june),
  DropDownValueModel(name: 'Julho', value: MonthEnum.july),
  DropDownValueModel(name: 'Agosto', value: MonthEnum.august),
  DropDownValueModel(name: 'Setembro', value: MonthEnum.september),
  DropDownValueModel(name: 'Outubro', value: MonthEnum.october),
  DropDownValueModel(name: 'Novembro', value: MonthEnum.november),
  DropDownValueModel(name: 'Dezembro', value: MonthEnum.december),
];
