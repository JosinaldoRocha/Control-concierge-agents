import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:control_concierge_agents/app/presentation/vacation/provider/vacation_provider.dart';
import 'package:control_concierge_agents/app/presentation/vacation/views/widgets/vacation_history_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';

class VacationHistoryPage extends ConsumerStatefulWidget {
  const VacationHistoryPage({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VacationHistoryPageState();
}

class _VacationHistoryPageState extends ConsumerState<VacationHistoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(vacationHistoryStateProvider.notifier)
        .load(agentId: widget.agent.id));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vacationHistoryStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de férias'),
        centerTitle: true,
      ),
      body: state.maybeWhen(
        loadInProgress: () => Center(
          child: SizedBox(
            height: 20,
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
            ),
          ),
        ),
        loadSuccess: (data) => data.isEmpty
            ? Center(
                child: Text('Nenhum registro de férias'),
              )
            : VacationHistoryListWidget(history: data),
        orElse: () => Container(),
      ),
    );
  }
}
