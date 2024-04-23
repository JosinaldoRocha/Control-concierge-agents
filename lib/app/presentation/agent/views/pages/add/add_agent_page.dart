import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/agent/provider/agent_provider.dart';
import 'package:control_concierge_agents/app/presentation/agent/states/add_agent_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/select_vacation_month_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_validators.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddAgentPage extends ConsumerStatefulWidget {
  const AddAgentPage({super.key});

  @override
  ConsumerState<AddAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends ConsumerState<AddAgentPage> {
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

  void addAgentListen() {
    ref.listen<AddAgentState>(
      addAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushNamed('/home');
          },
          loadFailure: (message) {},
          orElse: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    addAgentListen();

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
                  final agent = AgentModel(
                    id: const Uuid().v4(),
                    name: nameController.text,
                    bondType: bondTypeController.dropDownValue!.value,
                    unit: unitController.dropDownValue!.name,
                    vacationMonth: vacacionMonthContoller.dropDownValue?.name,
                    startVacation: startVacation,
                    endVacation: endVacation,
                    phone: phoneNumberController.text,
                    observations: observationsController.text,
                  );
                  if (forKey.currentState!.validate()) {
                    ref.read(addAgentStateProvider.notifier).add(agent);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
