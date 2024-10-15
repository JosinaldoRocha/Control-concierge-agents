import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/data/enums/work_status_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/style/app_text.dart';
import '../../../../widgets/modal/agent_modal_widget.dart';
import '../../../agent/provider/agent_provider.dart';
import '../mixin/agent_item_mixin.dart';

class AgentItemWidget extends ConsumerStatefulWidget {
  const AgentItemWidget({
    super.key,
    required this.agent,
    this.filter,
  });
  final AgentModel agent;
  final FilterType? filter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentItemWidgetState();
}

class _AgentItemWidgetState extends ConsumerState<AgentItemWidget>
    with AgentItemMixin {
  @override
  Widget build(BuildContext context) {
    final isWorking = widget.agent.workScale.any((date) =>
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
        backgroundColor: AppColor.cardBackground,
      ),
      onLongPress: () {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (context) => AgentModalWidget(
            title: 'Tem certeza que quer deletar esse agente?',
            description:
                'Ao deletar um agente você não poderá recupar seus dados',
            confirmTitle: 'Sim',
            onConfirm: () {
              ref
                  .read(deleteAgentStateProvider.notifier)
                  .delete(widget.agent.id);
              Navigator.pop(context);
            },
            cancelTitle: 'Cancelar',
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        );
      },
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/agent/details',
          arguments: widget.agent,
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
                      widget.agent.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.black,
                      ),
                    ),
                    const SpaceVertical.x1(),
                    Row(
                      children: [
                        if (widget.agent.status == "Ativo" &&
                            getWorkStatus(isWorking) == WorkStatus.inService)
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_outlined,
                                size: 14,
                                color: AppColor.lightPurple,
                              ),
                              const SpaceHorizontal.x1(),
                              Text(
                                workingHours(widget.agent.workShift),
                                style: AppText.text()
                                    .bodySmall!
                                    .copyWith(color: AppColor.lightPurple),
                              ),
                            ],
                          ),
                        Spacer(),
                        if (getWorkStatus(isWorking) == WorkStatus.isOnVacation)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              size: 20,
                              Icons.beach_access,
                              color: AppColor.secondary,
                            ),
                          ),
                        Text(
                          widget.agent.status != 'Ativo'
                              ? widget.agent.status
                              : getWorkStatus(isWorking).text,
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
          if (widget.filter != null && filterResult != null)
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
    switch (widget.filter) {
      case FilterType.bondType:
        return widget.agent.bondType.text;
      case FilterType.unit:
        return widget.agent.unit;
      case FilterType.vacationExpiration:
        return widget.agent.vacation?.vacationExpiration != null
            ? DateFormat('dd/MM/yyyy')
                .format(widget.agent.vacation!.vacationExpiration!)
            : null;
      default:
        return widget.agent.workShift;
    }
  }
}
