import 'package:control_concierge_agents/app/presentation/agent/views/pages/add/add_agent_page.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/pages/details/agent_details_page.dart';
import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';

class AgentRoutes extends IModuleRoutes {
  @override
  String get routeName => '/agent';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/add': (context) => AddAgentPage(
              agent: getArgs(context),
            ),
        '/details': (context) => AgentDetailsPage(
              agent: getArgs(context),
            ),
      };
}
