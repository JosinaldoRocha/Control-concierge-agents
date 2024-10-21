import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/add_vacation_history/add_vacation_history_state_notifier.dart';
import '../states/list_vacation_history/vacation_history_state_notifier.dart';

final vacationHistoryStateProvider =
    StateNotifierProvider<VacationHistoryStateNotifier, VacationHistoryState>(
  (ref) => VacationHistoryStateNotifier(
    dataSource: ref.read(vacationDataSourceProvider),
  ),
);

final addVacationHistoryStateProvider = StateNotifierProvider<
    AddVacationHistoryStateNotifier, AddVacationHistoryState>(
  (ref) => AddVacationHistoryStateNotifier(
    dataSource: ref.read(vacationDataSourceProvider),
  ),
);
