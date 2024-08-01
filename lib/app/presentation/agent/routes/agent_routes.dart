import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';
import '../views/pages/edit/edit_agent_page.dart';
import '../views/pages/details/agent_details_page.dart';

class AgentRoutes extends IModuleRoutes {
  @override
  String get routeName => '/agent';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/edit': (context) => EditAgentPage(
              agent: getArgs(context),
            ),
        '/details': (context) => AgentDetailsPage(
              agent: getArgs(context),
            ),
      };
}
