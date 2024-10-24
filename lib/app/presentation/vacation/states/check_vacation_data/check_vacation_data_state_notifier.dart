import 'package:control_concierge_agents/app/data/data_source/vacation_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef CheckVacationDataState = CommonState<CommonError, bool>;

class CheckVacationDataStateNotifier
    extends StateNotifier<CheckVacationDataState> {
  CheckVacationDataStateNotifier({required this.dataSource})
      : super(const CheckVacationDataState.initial());

  final VacationDataSource dataSource;

  Future<void> load() async {
    state = const CheckVacationDataState.loadInProgress();

    final result = await dataSource.checkAndUpdateVacationData();
    result.fold(
      (l) => state = CheckVacationDataState.loadFailure(l),
      (r) => state = CheckVacationDataState.loadSuccess(r),
    );
  }
}
