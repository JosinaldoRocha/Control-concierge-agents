import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:control_concierge_agents/app/presentation/vacation/states/check_vacation_data/check_vacation_data_state_notifier.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../../authentication/states/authentication/check_authentication_state_notifier.dart';
import '../../../vacation/provider/vacation_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(authenticationState.notifier).loadUser();
      ref.read(checkVacationStateProvider.notifier).load();
    });
  }

  void checkVacationDatalisten() {
    ref.listen<CheckVacationDataState>(
      checkVacationStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            ref.read(authenticationState.notifier).loadUser();
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Houve um erro ao carregar os dados. Tente novamente mais tarde!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void authListen() {
    ref.listen<Autenticationstate>(
      authenticationState,
      (previous, next) {
        if (next is IsLogged) {
          if (next.user!.displayName != null) {
            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            Navigator.of(context).pushReplacementNamed(
              '/profile/update',
            );
          }
        } else if (next is IsNotLogged) {
          Navigator.of(context).pushReplacementNamed('/auth/login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    checkVacationDatalisten();
    authListen();

    return Scaffold(
      backgroundColor: AppColor.lightPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/agent.png'),
          ),
          const SpaceVertical.x10(),
          const SizedBox(
            height: 10,
            width: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [AppColor.bgColor],
            ),
          ),
        ],
      ),
    );
  }
}
