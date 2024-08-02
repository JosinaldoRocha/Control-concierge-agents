import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:control_concierge_agents/app/presentation/profile/states/update_user_profile_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateUserProfileProvider = StateNotifierProvider<
    UpdateUserProfileStateNotifier, UpdateUserProfileState>(
  (ref) => UpdateUserProfileStateNotifier(
    dataSource: ref.read(userDataSourceProvider),
  ),
);
