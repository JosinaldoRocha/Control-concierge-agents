import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/select_vacation_month_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class AddAgentPage extends StatefulWidget {
  const AddAgentPage({super.key});

  @override
  State<AddAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends State<AddAgentPage> {
  final nameController = TextEditingController();
  final employmentRelationshipController = SingleValueDropDownController();
  final unitController = TextEditingController();
  final phoneNumberController = TextEditingController();
  DateTime? vacationMonth;

  Future<void> selectMonth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: vacationMonth,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year, 12),
    );
    //TODO ajustar seletor de data para mostrar apenas o mês

    if (picked != null && picked != vacationMonth) {
      setState(() {
        vacationMonth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          InputWidget(
            controller: nameController,
            hintText: 'Nome',
          ),
          const SpaceVertical.x4(),
          DropDownWidget(
            controller: employmentRelationshipController,
            list: [
              DropDownValueModel(name: BondTypeEnum.effective.text, value: 1),
              DropDownValueModel(name: BondTypeEnum.contract.text, value: 2),
            ],
            hintText: 'Vínculo empregatício',
          ),
          const SpaceVertical.x4(),
          InputWidget(
            controller: unitController,
            hintText: 'Lotação',
          ),
          const SpaceVertical.x4(),
          InputWidget(
            controller: phoneNumberController,
            hintText: 'Celular',
          ),
          const SpaceVertical.x4(),
          SelectVacationMonthWidget(
            hintText: 'Mês das férias',
            birthDate: vacationMonth,
            onTap: selectMonth,
          ),
        ],
      ),
    );
  }
}
