import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/core/helpers/common_state/common_state.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/agent/provider/agent_provider.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/mixin/edit/edit_agent_mixin.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/select_vacation_month_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_formatters.dart';
import 'package:control_concierge_agents/app/widgets/input/input_validators.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAgentPage extends ConsumerStatefulWidget {
  const EditAgentPage({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  ConsumerState<EditAgentPage> createState() => _EditAgentPageState();
}

class _EditAgentPageState extends ConsumerState<EditAgentPage>
    with EditAgentMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addAgentStateProvider);
    addAgentListen();

    return Scaffold(
      appBar: AppBar(),
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
                      isEnabled: false,
                    ),
                    const SpaceVertical.x4(),
                    DropDownWidget(
                      controller: bondTypeController,
                      list: bondTypeList,
                      hintText: 'Vínculo empregatício',
                      onChanged: (p0) => setState(() {}),
                    ),
                    const SpaceVertical.x4(),
                    DropDownWidget(
                      controller: unitController,
                      //TODO: tornar lista rolável
                      list: unitList,
                      hintText: 'Lotação',
                      listPadding: ListPadding(top: 5, bottom: 5),
                    ),
                    const SpaceVertical.x4(),
                    // if (bondTypeController.dropDownValue?.value ==
                    //     BondTypeEnum.effective)
                    Column(
                      children: [
                        SelectVacationMonthWidget(
                          hintText: 'Início das férias',
                          date: widget.agent.startVacation,
                          onTap: selectStartVacation,
                        ),
                        const SpaceVertical.x4(),
                        //if (startVacation != null)
                        Column(
                          children: [
                            SelectVacationMonthWidget(
                              hintText: 'Término das férias',
                              date: widget.agent.endVacation,
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
                isLoading: state is CommonStateLoadInProgress,
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
