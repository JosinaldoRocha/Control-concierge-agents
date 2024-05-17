import 'package:control_concierge_agents/app/core/style/app_colors.dart';
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
    String getInitials(String name) {
      List<String> nameParts = name.split(' ');
      String initials = '';

      int count = 0;

      for (String part in nameParts) {
        if (part.isNotEmpty && part[0].toUpperCase() == part[0]) {
          initials += part[0];
          count++;
        }
        if (count == 2) break;
      }
      return initials;
    }

    String filterToString() {
      switch (filter) {
        case FilterType.bondType:
          return agent.bondType.text;
        case FilterType.unit:
          return agent.unit;
        case FilterType.vacationPay:
          return agent.vacationPay != null
              ? DateFormat('dd/MM/yyyy').format(agent.vacationPay!)
              : '...';
        default:
          return agent.workShift;
      }
    }

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
          side: const BorderSide(color: AppColor.primary),
        ),
        backgroundColor: AppColor.white,
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
                child: Text(
                  agent.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColor.primary),
                ),
              ),
              const SpaceHorizontal.x2(),
              AgentProfileImageWidget(
                image: agent.imageUrl,
                size: 40,
                child: Text(
                  getInitials(agent.name),
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
}
