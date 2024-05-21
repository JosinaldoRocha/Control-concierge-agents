import 'package:control_concierge_agents/app/data/data_source/auth_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'authentication_state.dart';

class CheckAutenticationStatenotifier
    extends StateNotifier<Autenticationstate> {
  CheckAutenticationStatenotifier({
    required this.dataSource,
  }) : super(Initial());

  final AuthDataSource dataSource;

  void loadUser() async {
    state = Loading();

    await Future.delayed(const Duration(seconds: 1));
    final user = await dataSource.getUser();
    user.fold(
      (l) => state = IsNotLogged(),
      (data) async {
        if (data != null) {
          state = IsLogged(data);
        } else {
          state = IsNotLogged();
        }
      },
    );
  }
}
