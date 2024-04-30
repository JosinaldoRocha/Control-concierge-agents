import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> loadRoute(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    await Navigator.pushNamedAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      '/home',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    loadRoute(context);

    return Scaffold(
      backgroundColor: AppColor.mediumBlue,
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
