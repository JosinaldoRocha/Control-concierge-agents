import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/image/agent_profile_image.dart';

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

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        minimumSize: Size(200, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: isWorking ? AppColor.mediumGreen : AppColor.white,
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
              Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isWorking ? AppColor.primaryGreen : AppColor.lightGrey2,
                ),
                child: isWorking
                    ? Icon(
                        Icons.check,
                        size: 16,
                      )
                    : null,
              ),
              Expanded(
                child: Text(
                  agent.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: agent.bondType == BondTypeEnum.effective
                        ? AppColor.primary
                        : AppColor.primaryGrey,
                  ),
                ),
              ),
              const SpaceHorizontal.x2(),
              AgentProfileImageWidget(
                image: agent.imageUrl,
                size: 40,
              ),
            ],
          ),
          if (filter != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Divider(color: AppColor.lightGrey),
                Text(
                  filterToString(),
                  style: TextStyle(color: AppColor.error),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String filterToString() {
    switch (filter) {
      case FilterType.bondType:
        return agent.bondType.text;
      case FilterType.unit:
        return agent.unit;
      case FilterType.vacationPay:
        return agent.vacation?.vacationExpiration != null
            ? DateFormat('dd/MM/yyyy')
                .format(agent.vacation!.vacationExpiration!)
            : '!';
      default:
        return agent.workShift;
    }
  }
}
