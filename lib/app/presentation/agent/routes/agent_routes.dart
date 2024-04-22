import 'package:control_concierge_agents/app/presentation/agent/views/pages/add/add_agent_page.dart';
import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';

class AgentRoutes extends IModuleRoutes {
  @override
  String get routeName => '/agent';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/add': (_) => const AddAgentPage(),
      };
}
