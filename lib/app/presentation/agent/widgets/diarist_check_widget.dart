import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:flutter/material.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/style/app_text.dart';

class DiaristCheckWidget extends StatelessWidget {
  const DiaristCheckWidget({
    super.key,
    required this.isDiarist,
    required this.onTap,
    required this.agent,
  });
  final AgentModel? agent;
  final bool isDiarist;
  final Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.only(
        left: 20,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.lightGrey,
      ),
      child: Row(
        children: [
          Text(
            'Diarista',
            style: AppText.text().titleMedium?.copyWith(
                  color: agent != null ? Colors.black : AppColor.mediumBlue,
                ),
          ),
          const Spacer(),
          Checkbox(
            value: isDiarist,
            onChanged: onTap,
            side: BorderSide(
              color: AppColor.primary,
              width: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
