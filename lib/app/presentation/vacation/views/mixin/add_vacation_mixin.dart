import 'package:control_concierge_agents/app/data/enums/month_enum.dart';
import 'package:control_concierge_agents/app/data/models/vacation_history_model.dart';
import 'package:control_concierge_agents/app/data/models/vacation_model.dart';
import 'package:control_concierge_agents/app/presentation/vacation/states/add_vacation_history/add_vacation_history_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/vacation/views/widgets/add_vacation_widget.dart';
import 'package:control_concierge_agents/app/widgets/snack_bar/app_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/errors/common_errors.dart';
import '../../../../core/style/app_colors.dart';
import '../../../agent/provider/agent_provider.dart';
import '../../../agent/states/edit/edit_agent_state_notifier.dart';
import '../../provider/vacation_provider.dart';

mixin AddVacationMixin<T extends AddVacationWidget> on ConsumerState<T> {
  final formKey = GlobalKey<FormState>();
  final vestingPeriodController = TextEditingController();

  DateTime? vacationExpiration;
  DateTime? startVacation;
  DateTime? endVacation;

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

  Future<void> selectvacationExpiration() async {
    final currentDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(currentDate.year, currentDate.month - 11),
      lastDate: DateTime(currentDate.year, currentDate.month + 13, 0),
    );

    if (picked != null && picked != vacationExpiration) {
      setState(() {
        vacationExpiration = picked;
      });
    }
  }

  void editAgentListen() {
    ref.listen<EditAgentState>(
      editAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            if (vacationExpiration != null &&
                startVacation != null &&
                endVacation != null &&
                vestingPeriodController.text.isNotEmpty) {
              final currentYear = DateTime.now().year;

              final vacationHistory = VacationHistoryModel(
                id: '${currentYear}${vestingPeriodController.text}',
                year: currentYear,
                vestingPeriod: vestingPeriodController.text,
                startDate: startVacation!,
                endDate: endVacation!,
              );

              ref.read(addVacationHistoryStateProvider.notifier).add(
                    agentId: widget.agent.id,
                    vacationHistory: vacationHistory,
                  );
            } else {
              loadSuccess(data);
            }
          },
          loadFailure: loadFailure,
          orElse: () {},
        );
      },
    );
  }

  void addVacationHistoryListen() {
    ref.listen<AddVacationHistoryState>(
      addVacationHistoryStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: loadSuccess,
          loadFailure: loadFailure,
          orElse: () {},
        );
      },
    );
  }

  void loadSuccess(bool data) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
    );
    AppSnackBar.show(
      context,
      'Férias adicionada com sucesso!',
      AppColor.secondary,
    );
  }

  void loadFailure(CommonError message) {
    AppSnackBar.show(
      context,
      'Houve um erro ao adicionar férias ao agente. Tente novamente mais tarde!',
      AppColor.error,
    );
  }

  void onTapButton() {
    if (formKey.currentState!.validate()) {
      final agent = widget.agent.copyWith(
        vacation: vacationExpiration != null
            ? VacationModel(
                vacationMonth: startVacation != null
                    ? MonthEnum.fromInt(
                        startVacation!.month,
                      ).text
                    : null,
                vacationExpiration: vacationExpiration,
                startVacation: startVacation,
                endVacation: endVacation,
                vestingPeriod: vestingPeriodController.text,
              )
            : null,
      );

      ref.read(editAgentStateProvider.notifier).edit(agent);
    }
  }
}
