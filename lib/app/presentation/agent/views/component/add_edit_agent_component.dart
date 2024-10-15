import 'package:control_concierge_agents/app/data/enums/date_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/mixin/add-edit/add_edit_agent_mixin.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/helpers/common_state/common_state.dart';
import '../../../../data/enums/bond_type_enum.dart';
import '../../../../data/models/agent_model.dart';
import '../../../../widgets/button/button_widget.dart';
import '../../../../widgets/dropdown/dropdown_widget.dart';
import '../../../../widgets/input/input_formatters.dart';
import '../../../../widgets/input/input_validators.dart';
import '../../../../widgets/input/input_widget.dart';
import '../../../../widgets/select_date/select_date_widget.dart';
import '../../../../widgets/spacing/spacing.dart';
import '../../provider/agent_provider.dart';
import '../../widgets/agent_image_widget.dart';
import '../../widgets/diarist_check_widget.dart';

class AddEditAgentComponent extends ConsumerStatefulWidget {
  const AddEditAgentComponent({
    super.key,
    this.agent,
  });
  final AgentModel? agent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEditAgentComponentState();
}

class _AddEditAgentComponentState extends ConsumerState<AddEditAgentComponent>
    with AddEditAgentMixin {
  @override
  Widget build(BuildContext context) {
    unitList.sort((a, b) => a.name.compareTo(b.name));
    final addState = ref.watch(addAgentStateProvider);
    final editState = ref.watch(editAgentStateProvider);

    addAgentListen();
    editAgentListen();

    return SafeArea(
      child: Padding(
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
                      controller: statusController,
                      list: agentStatusList,
                      hintText: 'Status',
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
                      datePickerType: DatePickerType.reference,
                      label: 'Data referência',
                      hintText: 'Selecione a data referência',
                      date: referenceDate,
                      onTap: () => selectReferenceDate(isDiarist),
                      onClean: () {
                        setState(() {
                          referenceDate = null;
                        });
                      },
                    ),
                    const SpaceVertical.x4(),
                    if (bondTypeController.dropDownValue?.value ==
                        BondTypeEnum.effective)
                      Column(
                        children: [
                          SelectDateWidget(
                            datePickerType: DatePickerType.vacationExpiration,
                            label: 'Vencimento das férias',
                            hintText: 'Vencimento das férias',
                            date: vacation?.vacationExpiration,
                            onTap: selectvacationExpiration,
                            onClean: () {
                              setState(() {
                                vacation?.vacationExpiration = null;
                              });
                            },
                          ),
                          const SpaceVertical.x4(),
                          SelectDateWidget(
                            datePickerType: DatePickerType.startVacation,
                            label: 'Início das férias',
                            hintText: 'Início das férias',
                            date: vacation?.startVacation,
                            onTap: selectStartVacation,
                            onClean: () {
                              setState(() {
                                vacation?.startVacation = null;
                              });
                            },
                          ),
                          const SpaceVertical.x4(),
                          if (vacation?.startVacation != null)
                            Column(
                              children: [
                                SelectDateWidget(
                                  datePickerType: DatePickerType.endVacation,
                                  label: 'Término das férias',
                                  hintText: 'Término das férias',
                                  date: vacation?.endVacation,
                                  onTap: selectEndVacation,
                                  onClean: () {
                                    setState(() {
                                      vacation?.endVacation = null;
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
                title: widget.agent == null ? 'Salvar agente' : 'Atualizar',
                onTap: onTapButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
