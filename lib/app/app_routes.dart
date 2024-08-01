import 'package:control_concierge_agents/app/presentation/agent/routes/agent_routes.dart';
import 'package:control_concierge_agents/app/presentation/authentication/routes/atuh_routes.dart';
import 'package:control_concierge_agents/app/presentation/profile/routes/profile_routes.dart';
import 'package:flutter/material.dart';
import 'core/navigator/navigator.dart';
import 'presentation/home/views/pages/home_page.dart';

class AppRoutes extends IAppRoutes {
  @override
  List<IModuleRoutes> get features => [
        AuthRoutes(),
        AgentRoutes(),
        ProfileRoutes(),
      ];

  @override
  String get initialRoute => '/auth';

  @override
  Map<String, Widget Function(BuildContext p1)> get routes => {
        '/home': (_) => const HomePage(),
      };
}
