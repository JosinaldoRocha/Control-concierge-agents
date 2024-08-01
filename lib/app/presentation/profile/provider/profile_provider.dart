import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:control_concierge_agents/app/presentation/profile/states/complete/complete_profile_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/edit/edit_user_state_notifier.dart';

final editUserProvider =
    StateNotifierProvider<EditUserStateNotifier, EditUserState>(
  (ref) => EditUserStateNotifier(
    dataSource: ref.read(userDataSourceProvider),
  ),
);

final completeProfileProvider =
    StateNotifierProvider<CompleteProfileStateNotifier, CompleteProfileState>(
  (ref) => CompleteProfileStateNotifier(
    dataSource: ref.read(userDataSourceProvider),
  ),
);
