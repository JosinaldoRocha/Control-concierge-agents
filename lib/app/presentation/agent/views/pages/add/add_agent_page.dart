import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/select_vacation_month_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_validators.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
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
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final phoneNumberController = TextEditingController();
  final vacacionMonthContoller = SingleValueDropDownController();
  final observationsController = TextEditingController();
  final forKey = GlobalKey<FormState>();

  DateTime? startVacation;
  DateTime? endVacation;

  Future<void> selectStartVacation() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startVacation,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year, 12),
    );

    if (picked != null && picked != startVacation) {
      setState(() {
        startVacation = picked;
      });
    }
  }

  Future<void> selectEndVacation() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endVacation,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year + 1, 1),
    );

    if (picked != null && picked != endVacation) {
      setState(() {
        endVacation = picked;
      });
    }
  }

  var teste = BondTypeEnum.effective;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: forKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 16),
                  children: [
                    InputWidget(
                      controller: nameController,
                      hintText: 'Nome',
                      validator: InputValidators.fullName,
                    ),
                    const SpaceVertical.x4(),
                    DropDownWidget(
                      controller: bondTypeController,
                      list: bondTypeList,
                      hintText: 'Vínculo empregatício',
                      onChanged: (p0) {
                        setState(() {
                          teste = p0.value;
                        });
                      },
                    ),
                    const SpaceVertical.x4(),
                    DropDownWidget(
                      controller: unitController,
                      //TODO: tornar lista rolável
                      list: unitList,
                      hintText: 'Lotação',
                    ),
                    if (teste == BondTypeEnum.effective)
                      Column(
                        children: [
                          const SpaceVertical.x4(),
                          DropDownWidget(
                            controller: vacacionMonthContoller,
                            list: monthList,
                            hintText: 'Mês de férias',
                          ),
                          const SpaceVertical.x4(),
                          SelectVacationMonthWidget(
                            hintText: 'Início das férias',
                            birthDate: startVacation,
                            onTap: selectStartVacation,
                          ),
                          const SpaceVertical.x4(),
                          SelectVacationMonthWidget(
                            hintText: 'Término das férias',
                            birthDate: endVacation,
                            onTap: selectEndVacation,
                          ),
                        ],
                      ),
                    const SpaceVertical.x4(),
                    InputWidget(
                      controller: phoneNumberController,
                      hintText: 'Celular',
                      validator: InputValidators.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SpaceVertical.x4(),
                    InputWidget(
                      controller: observationsController,
                      hintText: 'Observações',
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                title: 'Salvar agente',
                onTap: () {
                  if (forKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
