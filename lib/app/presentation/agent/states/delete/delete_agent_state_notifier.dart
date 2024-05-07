import 'package:control_concierge_agents/app/data/data_source/agent_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef DeleteAgentState = CommonState<CommonError, bool>;

class DeleteAgentStateNotifier extends StateNotifier<DeleteAgentState> {
  DeleteAgentStateNotifier({required this.dataSource})
      : super(const DeleteAgentState.initial());

  final AgentDataSource dataSource;

  Future<void> delete(String agentId) async {
    state = const DeleteAgentState.loadInProgress();

    final result = await dataSource.deleteAgent(agentId);
    result.fold(
      (l) => state = DeleteAgentState.loadFailure(l),
      (r) => state = DeleteAgentState.loadSuccess(r),
    );
  }
}
