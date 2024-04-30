import 'package:control_concierge_agents/app/presentation/agent/routes/agent_routes.dart';
import 'package:control_concierge_agents/app/presentation/splash/views/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'core/navigator/navigator.dart';
import 'presentation/home/views/pages/home_page.dart';

class AppRoutes extends IAppRoutes {
  @override
  List<IModuleRoutes> get features => [
        AgentRoutes(),
      ];

  @override
  String get initialRoute => '/';

  @override
  Map<String, Widget Function(BuildContext p1)> get routes => {
        '/': (_) => const SplashPage(),
        '/home': (_) => const HomePage(),
      };
}
