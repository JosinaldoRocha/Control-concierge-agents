import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/core/helpers/common_state/common_state.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/agent/provider/agent_provider.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/mixin/add-edit/add_edit_agent_mixin.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_image_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/diarist_check_widget.dart';
import 'package:control_concierge_agents/app/widgets/select_date/select_date_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/dropdown/dropdown_widget.dart';
import 'package:control_concierge_agents/app/widgets/input/input_formatters.dart';
import 'package:control_concierge_agents/app/widgets/input/input_validators.dart';
import 'package:control_concierge_agents/app/widgets/input/input_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEditAgentPage extends ConsumerStatefulWidget {
  const AddEditAgentPage({super.key, this.agent});
  final AgentModel? agent;

  @override
  ConsumerState<AddEditAgentPage> createState() => _AddAgentPageState();
}

class _AddAgentPageState extends ConsumerState<AddEditAgentPage>
    with AddEditAgentMixin {
  @override
  Widget build(BuildContext context) {
    unitList.sort((a, b) => a.name.compareTo(b.name));
    final addState = ref.watch(addAgentStateProvider);
    final editState = ref.watch(editAgentStateProvider);
    addAgentListen();
    editAgentListen();

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
                    AgentSelectImageWidget(
                      image: image,
                      onTap: getImage,
                    ),
                    const SpaceVertical.x4(),
                    InputWidget(
                      controller: nameController,
                      hintText: 'Nome',
                      validator: InputValidators.fullName,
                      isEnabled: widget.agent == null,
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
                    DropDownWidget(
                      controller: workShiftController,
                      list: workShiftList,
                      hintText: 'Turno',
                    ),
                    DiaristCheckWidget(
                      agent: widget.agent,
                      isDiarist: isDiarist,
                      onTap: (p0) {
                        setState(() {
                          isDiarist = p0!;
                        });
                      },
                    ),
                    SelectDateWidget(
                      hintText: 'Selecione a data referência',
                      date: referenceDate,
                      onTap: selectReferenceDate,
                      onClean: () {
                        setState(() {
                          referenceDate = null;
                        });
                      },
                      validator: (DateTime? date) {
                        if (date == null) {
                          return 'Por favor, selecione uma data referência.';
                        }
                        return null;
                      },
                    ),
                    const SpaceVertical.x4(),
                    if (bondTypeController.dropDownValue?.value ==
                        BondTypeEnum.effective)
                      Column(
                        children: [
                          SelectDateWidget(
                            hintText: 'Vencimento das férias',
                            date: vacationPay,
                            onTap: selectVacationPay,
                            onClean: () {
                              setState(() {
                                vacationPay = null;
                              });
                            },
                          ),
                          const SpaceVertical.x4(),
                          SelectDateWidget(
                            hintText: 'Início das férias',
                            date: startVacation,
                            onTap: selectStartVacation,
                            onClean: () {
                              setState(() {
                                startVacation = null;
                              });
                            },
                          ),
                          const SpaceVertical.x4(),
                          if (startVacation != null)
                            Column(
                              children: [
                                SelectDateWidget(
                                  hintText: 'Término das férias',
                                  date: endVacation,
                                  onTap: selectEndVacation,
                                  onClean: () {
                                    setState(() {
                                      endVacation = null;
                                    });
                                  },
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
                isLoading: addState is CommonStateLoadInProgress ||
                    editState is CommonStateLoadInProgress,
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
