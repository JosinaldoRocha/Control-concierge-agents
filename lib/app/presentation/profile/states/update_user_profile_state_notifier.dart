import 'package:control_concierge_agents/app/data/data_source/user_data_source.dart';
import 'package:control_concierge_agents/app/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/helpers/helpers.dart';

typedef UpdateUserProfileState = CommonState<CommonError, bool>;

class UpdateUserProfileStateNotifier
    extends StateNotifier<UpdateUserProfileState> {
  UpdateUserProfileStateNotifier({required this.dataSource})
      : super(const UpdateUserProfileState.initial());

  final UserDataSource dataSource;

  Future<void> load({required UserModel user}) async {
    state = const UpdateUserProfileState.loadInProgress();

    final result = await dataSource.updateUserProfile(user: user);
    result.fold(
      (l) => state = UpdateUserProfileState.loadFailure(l),
      (r) => state = UpdateUserProfileState.loadSuccess(r),
    );
  }
}
