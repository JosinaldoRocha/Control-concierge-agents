import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../data/models/vacation_history_model.dart';
import '../../../../widgets/spacing/spacing.dart';

class VacationHistoryListWidget extends StatelessWidget {
  const VacationHistoryListWidget({
    super.key,
    required this.history,
  });
  final List<VacationHistoryModel> history;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10).copyWith(bottom: 4),
        decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: _buildHistoryItem(history, index),
      ),
      separatorBuilder: (context, index) => const SpaceVertical.x4(),
      itemCount: history.length,
    );
  }

  Column _buildHistoryItem(
    List<VacationHistoryModel> data,
    int index,
  ) {
    final history = data[index];
    return Column(
      children: [
        Text(
          history.year.toString(),
          style: AppText.text().titleMedium,
        ),
        _buildItem('Vencimento:',
            DateFormat('dd/MM/yyyy').format(history.vacationExpiration)),
        _buildItem('Início:', DateFormat('dd/MM').format(history.startDate)),
        _buildItem('Término:', DateFormat('dd/MM').format(history.endDate)),
        _buildItem('Período aquisitivo:', history.vestingPeriod),
      ],
    );
  }

  Padding _buildItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SpaceHorizontal.x1(),
          Expanded(
            child: SelectableText(
              description,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
