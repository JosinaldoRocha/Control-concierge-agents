import 'package:control_concierge_agents/app/data/enums/month_enum.dart';
import 'package:control_concierge_agents/app/widgets/snack_bar/app_snack_bar_widget.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../data/models/agent_model.dart';
import '../../../provider/agent_provider.dart';
import '../../../states/add_agent_state_notifier.dart';
import '../../../states/edit/edit_agent_state_notifier.dart';
import '../../pages/add_edit/add_edit_agent_page.dart';

mixin AddEditAgentMixin<T extends AddEditAgentPage> on ConsumerState<T> {
  final nameController = TextEditingController();
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final phoneNumberController = TextEditingController();
  final observationsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime? startVacation;
  DateTime? endVacation;

  @override
  void initState() {
    super.initState();
    if (widget.agent != null) {
      nameController.text = widget.agent!.name;
      phoneNumberController.text = widget.agent!.phone!;
      bondTypeController.setDropDown(
        bondTypeList.firstWhere((e) => e.value == widget.agent!.bondType),
      );
      unitController.setDropDown(
        unitList.firstWhere((e) => e.name == widget.agent!.unit),
      );
      observationsController.text = widget.agent!.observations!;
      startVacation = widget.agent!.startVacation;
      endVacation = widget.agent!.endVacation;
    }
  }

  Future<DateTime?> _buildShowDatePicker(bool isStartDate) {
    return startVacation == null
        ? showDatePicker(
            context: context,
            firstDate: DateTime(DateTime.now().year, 1),
            lastDate: DateTime(DateTime.now().year + 1, 1, 0),
          )
        : showDatePicker(
            initialDate: isStartDate ? startVacation : null,
            context: context,
            firstDate: DateTime(
              startVacation!.year,
              isStartDate ? 1 : startVacation!.month,
              isStartDate ? 1 : startVacation!.day + 1,
            ),
            lastDate: DateTime(
              startVacation!.year,
              isStartDate ? 12 : startVacation!.month + 1,
              isStartDate ? 31 : startVacation!.day + 2,
            ),
          );
  }

  Future<void> selectStartVacation() async {
    final DateTime? picked = await _buildShowDatePicker(true);

    if (picked != null && picked != startVacation) {
      setState(() {
        startVacation = picked;
      });
    }
  }

  Future<void> selectEndVacation() async {
    final DateTime? picked = await _buildShowDatePicker(false);

    if (picked != null && picked != endVacation) {
      setState(() {
        endVacation = picked;
      });
    }
  }

  void addAgentListen() {
    ref.listen<AddAgentState>(
      addAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushReplacementNamed('/home');
            AppSnackBar.show(
              context,
              'Agente adicionado com sucesso!',
              AppColor.secondary,
            );
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Houve um erro ao adicionar o agente. Tente novamente mais tarde!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void editAgentListen() {
    ref.listen<EditAgentState>(
      editAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushReplacementNamed('/home');
            AppSnackBar.show(
              context,
              'Agente atualizado com sucesso!',
              AppColor.secondary,
            );
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Houve um erro ao atualizar os dados do agente. Tente novamente mais tarde!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void onTapButton() {
    if (formKey.currentState!.validate()) {
      final agent = AgentModel(
        id: widget.agent == null ? const Uuid().v4() : widget.agent!.id,
        name: nameController.text,
        bondType: bondTypeController.dropDownValue?.value,
        unit: unitController.dropDownValue!.name,
        vacationMonth: startVacation != null
            ? MonthEnum.fromInt(startVacation!.month).text
            : null,
        startVacation: startVacation,
        endVacation: endVacation,
        phone: phoneNumberController.text,
        observations: observationsController.text,
      );
      if (widget.agent == null) {
        ref.read(addAgentStateProvider.notifier).add(agent);
      } else {
        ref.read(editAgentStateProvider.notifier).edit(agent);
      }
    }
  }
}
