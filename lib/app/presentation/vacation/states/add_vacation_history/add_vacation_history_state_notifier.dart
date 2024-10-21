import 'package:control_concierge_agents/app/data/data_source/vacation_data_source.dart';
import 'package:control_concierge_agents/app/data/models/vacation_history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef AddVacationHistoryState = CommonState<CommonError, bool>;

class AddVacationHistoryStateNotifier
    extends StateNotifier<AddVacationHistoryState> {
  AddVacationHistoryStateNotifier({required this.dataSource})
      : super(const AddVacationHistoryState.initial());

  final VacationDataSource dataSource;

  Future<void> add({
    required agentId,
    required VacationHistoryModel vacationHistory,
  }) async {
    state = const AddVacationHistoryState.loadInProgress();

    final result = await dataSource.addVacationHistory(
      agentId: agentId,
      vacationHistory: vacationHistory,
    );
    result.fold(
      (l) => state = AddVacationHistoryState.loadFailure(l),
      (r) => state = AddVacationHistoryState.loadSuccess(r),
    );
  }
}
