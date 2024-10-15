import 'package:control_concierge_agents/app/presentation/home/views/widgets/agent_item_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/enums/work_status_enum.dart';

mixin AgentItemMixin<T extends AgentItemWidget> on ConsumerState<T> {
  final currentDate = DateTime.now();

  String workingHours(String workShift) {
    if (workShift.contains('Diurno')) {
      return '06:00 - 18:00';
    } else if (workShift.contains('EJA')) {
      return '18:00 - 22:00';
    } else {
      return '18:00 - 06:00';
    }
  }

  WorkStatus getWorkStatus(bool isWorking) {
    final currentDate = DateTime.now();
    final startVacation = widget.agent.vacation?.startVacation;
    final endVacation = widget.agent.vacation?.endVacation;

    bool isSameDay(DateTime? date) =>
        date != null &&
        date.day == currentDate.day &&
        date.month == currentDate.month &&
        date.year == currentDate.year;

    bool isOnVacationPeriod = startVacation != null &&
        endVacation != null &&
        (startVacation.isBefore(currentDate) || isSameDay(startVacation)) &&
        (endVacation.isAfter(currentDate) || isSameDay(endVacation));

    if (isOnVacationPeriod) {
      return WorkStatus.isOnVacation;
    }

    return isWorking ? WorkStatus.inService : WorkStatus.isOff;
  }
}
