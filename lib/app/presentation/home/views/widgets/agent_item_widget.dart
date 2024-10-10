import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/enums/agent_status_enum.dart';
import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/image/profile_image_widget.dart';

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
    final isOnVacation = AgentStatus.isOnVacationFromDate(agent.vacation) ==
        AgentStatus.isOnVacation;

    final isWorking = agent.workScale.any((date) =>
        date.day == currentDate.day &&
        date.month == currentDate.month &&
        date.year == currentDate.year);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(8).copyWith(left: 12),
        minimumSize: Size(200, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor:
            !isOnVacation && isWorking ? AppColor.primary : AppColor.white,
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
              if (isOnVacation)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.beach_access,
                    color: AppColor.primary,
                  ),
                ),
              Expanded(
                child: Text(
                  agent.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: !isOnVacation && isWorking
                        ? AppColor.white
                        : AppColor.primary,
                  ),
                ),
              ),
              const SpaceHorizontal.x2(),
              ProfileImageWidget(
                image: agent.imageUrl,
                size: 40,
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
