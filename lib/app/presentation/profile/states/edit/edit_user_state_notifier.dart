import 'package:control_concierge_agents/app/data/data_source/user_data_source.dart';
import 'package:control_concierge_agents/app/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/helpers.dart';

typedef EditUserState = CommonState<CommonError, bool>;

class EditUserStateNotifier extends StateNotifier<EditUserState> {
  EditUserStateNotifier({required this.dataSource})
      : super(const EditUserState.initial());

  final UserDataSource dataSource;

  Future<void> load({required UserModel user}) async {
    state = const EditUserState.loadInProgress();

    final result = await dataSource.editUser(user: user);
    result.fold(
      (l) => state = EditUserState.loadFailure(l),
      (r) => state = EditUserState.loadSuccess(r),
    );
  }
}
