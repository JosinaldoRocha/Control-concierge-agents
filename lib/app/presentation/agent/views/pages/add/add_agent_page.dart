import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/mixin/add_agent_mixin.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/select_vacation_month_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_formatters.dart';
import 'package:control_concierge_agents/app/widgets/input/input_validators.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAgentPage extends ConsumerStatefulWidget {
  const AddAgentPage({super.key});

  @override
  ConsumerState<AddAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends ConsumerState<AddAgentPage>
    with AddAgentMixin {
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
          key: formKey,
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
                          //TODO: lidar com ação ao tocar em limpar campo de texto
                          bondType = p0.value;
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
                    const SpaceVertical.x4(),
                    if (bondType == BondTypeEnum.effective)
                      Column(
                        children: [
                          SelectVacationMonthWidget(
                            hintText: 'Início das férias',
                            birthDate: startVacation,
                            onTap: selectStartVacation,
                          ),
                          const SpaceVertical.x4(),
                          if (startVacation != null)
                            Column(
                              children: [
                                SelectVacationMonthWidget(
                                  hintText: 'Término das férias',
                                  birthDate: endVacation,
                                  onTap: selectEndVacation,
                                ),
                                const SpaceVertical.x4(),
                              ],
                            ),
                        ],
                      ),
                    InputWidget(
                      controller: phoneNumberController,
                      hintText: 'Celular',
                      validator: InputValidators.phone,
                      inputFormatters: [InputFormatters.phone()],
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
                onTap: onTapButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
