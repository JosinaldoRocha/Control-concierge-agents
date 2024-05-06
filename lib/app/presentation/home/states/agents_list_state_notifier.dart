import 'package:control_concierge_agents/app/data/data_source/agent_data_source.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/helpers/helpers.dart';

typedef AgentListState = CommonState<CommonError, List<AgentModel>>;

class AgentListStateNotifier extends StateNotifier<AgentListState> {
  AgentListStateNotifier({required this.dataSource})
      : super(const AgentListState.initial());

  final AgentDataSource dataSource;

  Future<void> load(String? filter) async {
    state = const AgentListState.loadInProgress();

    final result = await dataSource.getAgents(filter ?? 'name');
    result.fold(
      (l) => state = AgentListState.loadFailure(l),
      (r) => state = AgentListState.loadSuccess(r),
    );
  }
}
