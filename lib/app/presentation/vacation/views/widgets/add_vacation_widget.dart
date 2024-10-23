import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/vacation/views/mixin/add_vacation_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/common_state/common_state.dart';
import '../../../../data/enums/date_type_enum.dart';
import '../../../../widgets/button/button_widget.dart';
import '../../../../widgets/select_date/select_date_widget.dart';
import '../../../../widgets/spacing/vertical_space_widget.dart';
import '../../../agent/provider/agent_provider.dart';

class AddVacationWidget extends ConsumerStatefulWidget {
  const AddVacationWidget({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddVacationWidgetState();
}

class _AddVacationWidgetState extends ConsumerState<AddVacationWidget>
    with AddVacationMixin {
  @override
  Widget build(BuildContext context) {
    editAgentListen();
    addVacationHistoryListen();

    final editState = ref.watch(editAgentStateProvider);

    return Padding(
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
                  Column(
                    children: [
                      SelectDateWidget(
                        datePickerType: DatePickerType.vacationExpiration,
                        label: 'Vencimento das férias',
                        hintText: 'Vencimento das férias',
                        date: vacationExpiration,
                        onTap: selectvacationExpiration,
                        onClean: () {
                          setState(() {
                            vacationExpiration = null;
                            startVacation = null;
                            endVacation = null;
                          });
                        },
                      ),
                      const SpaceVertical.x4(),
                      if (vacationExpiration != null)
                        Column(
                          children: [
                            SelectDateWidget(
                              datePickerType: DatePickerType.startVacation,
                              label: 'Início das férias',
                              hintText: 'Início das férias',
                              date: startVacation,
                              onTap: selectStartVacation,
                              onClean: () {
                                setState(() {
                                  startVacation = null;
                                  endVacation = null;
                                });
                              },
                            ),
                            const SpaceVertical.x4(),
                          ],
                        ),
                      if (startVacation != null)
                        Column(
                          children: [
                            SelectDateWidget(
                              datePickerType: DatePickerType.endVacation,
                              label: 'Término das férias',
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
                ],
              ),
            ),
            ButtonWidget(
              isLoading: editState is CommonStateLoadInProgress,
              title: 'Salvar',
              onTap: onTapButton,
            ),
          ],
        ),
      ),
    );
  }
}
