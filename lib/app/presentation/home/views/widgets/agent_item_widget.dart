import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/data/enums/work_status_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/style/app_text.dart';

class AgentItemWidget extends StatelessWidget {
  const AgentItemWidget({
    super.key,
    required this.agent,
    this.filter,
  });
  final AgentModel agent;
  final FilterType? filter;

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();

    final isWorking = agent.workScale.any((date) =>
        date.day == currentDate.day &&
        date.month == currentDate.month &&
        date.year == currentDate.year);

    String workingHours(String workShift) {
      if (workShift.contains('Diurno')) {
        return '06:00 - 18:00';
      } else if (workShift.contains('EJA')) {
        return '18:00 - 22:00';
      } else {
        return '18:00 - 06:00';
      }
    }

    WorkStatus getWorkStatus() {
      final currentDate = DateTime.now();
      final startVacation = agent.vacation?.startVacation;
      final endVacation = agent.vacation?.endVacation;

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

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(8).copyWith(left: 12),
        minimumSize: Size(200, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: AppColor.cardBackground,
      ),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/agent/details',
          arguments: agent,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.black,
                      ),
                    ),
                    const SpaceVertical.x1(),
                    Row(
                      children: [
                        if (agent.status == "Ativo" &&
                            getWorkStatus() == WorkStatus.inService)
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_outlined,
                                size: 14,
                                color: AppColor.lightPurple,
                              ),
                              const SpaceHorizontal.x1(),
                              Text(
                                workingHours(agent.workShift),
                                style: AppText.text()
                                    .bodySmall!
                                    .copyWith(color: AppColor.lightPurple),
                              ),
                            ],
                          ),
                        Spacer(),
                        if (getWorkStatus() == WorkStatus.isOnVacation)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              size: 20,
                              Icons.beach_access,
                              color: AppColor.secondary,
                            ),
                          ),
                        Text(
                          agent.status != 'Ativo'
                              ? agent.status
                              : getWorkStatus().text,
                          style: AppText.text().bodyMedium!.copyWith(
                                color: AppColor.secondary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (filter != null && filterResult != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Divider(color: AppColor.lightGrey),
                Text(
                  filterResult!,
                  style: TextStyle(color: AppColor.error),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String? get filterResult {
    switch (filter) {
      case FilterType.bondType:
        return agent.bondType.text;
      case FilterType.unit:
        return agent.unit;
      case FilterType.vacationExpiration:
        return agent.vacation?.vacationExpiration != null
            ? DateFormat('dd/MM/yyyy')
                .format(agent.vacation!.vacationExpiration!)
            : null;
      default:
        return agent.workShift;
    }
  }
}
