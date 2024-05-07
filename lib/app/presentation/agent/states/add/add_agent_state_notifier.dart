import 'package:control_concierge_agents/app/data/data_source/agent_data_source.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef AddAgentState = CommonState<CommonError, bool>;

class AddAgentStateNotifier extends StateNotifier<AddAgentState> {
  AddAgentStateNotifier({required this.dataSource})
      : super(const AddAgentState.initial());

  final AgentDataSource dataSource;

  Future<void> add(AgentModel agent) async {
    state = const AddAgentState.loadInProgress();

    final result = await dataSource.addAgent(agent);
    result.fold(
      (l) => state = AddAgentState.loadFailure(l),
      (r) => state = AddAgentState.loadSuccess(r),
    );
  }
}
