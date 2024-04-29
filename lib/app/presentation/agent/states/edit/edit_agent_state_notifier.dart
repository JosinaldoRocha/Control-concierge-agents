import 'package:control_concierge_agents/app/data/data_source/agent_data_source.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef EditAgentState = CommonState<CommonError, bool>;

class EditAgentStateNotifier extends StateNotifier<EditAgentState> {
  EditAgentStateNotifier({required this.dataSource})
      : super(const EditAgentState.initial());

  final AgentDataSource dataSource;

  Future<void> edit(AgentModel agent) async {
    state = const EditAgentState.loadInProgress();

    final result = await dataSource.addAgent(agent);
    result.fold(
      (l) => state = EditAgentState.loadFailure(l),
      (r) => state = EditAgentState.loadSuccess(r),
    );
  }
}
