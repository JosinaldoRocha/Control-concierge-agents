import 'package:control_concierge_agents/app/data/providers/data_provider.dart';
import 'package:control_concierge_agents/app/presentation/authentication/states/authentication/check_authentication_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/authentication/states/logout/logout_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/authentication/states/sign_in/sign_in_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationState =
    StateNotifierProvider<CheckAutenticationStatenotifier, Autenticationstate>(
  (ref) => CheckAutenticationStatenotifier(
    dataSource: ref.read(authDataSourceProvider),
  ),
);

final signInProvider = StateNotifierProvider<SignInStateNotifier, SignInState>(
  (ref) => SignInStateNotifier(
    dataSource: ref.read(authDataSourceProvider),
  ),
);

final logoutProvider = StateNotifierProvider<LogoutStateNotifier, LogoutState>(
  (ref) => LogoutStateNotifier(
    dataSource: ref.read(authDataSourceProvider),
  ),
);
