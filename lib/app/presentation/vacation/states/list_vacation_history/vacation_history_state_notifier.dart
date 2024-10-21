import 'package:control_concierge_agents/app/data/data_source/vacation_data_source.dart';
import 'package:control_concierge_agents/app/data/models/vacation_history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef VacationHistoryState
    = CommonState<CommonError, List<VacationHistoryModel>>;

class VacationHistoryStateNotifier extends StateNotifier<VacationHistoryState> {
  VacationHistoryStateNotifier({required this.dataSource})
      : super(const VacationHistoryState.initial());

  final VacationDataSource dataSource;

  Future<void> load({
    required String agentId,
  }) async {
    state = const VacationHistoryState.loadInProgress();

    final result = await dataSource.getVacationHistory(agentId: agentId);
    result.fold(
      (l) => state = VacationHistoryState.loadFailure(l),
      (r) => state = VacationHistoryState.loadSuccess(r),
    );
  }
}
