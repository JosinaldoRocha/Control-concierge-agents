import 'package:control_concierge_agents/app/presentation/vacation/views/pages/vacation_history_page.dart';
import 'package:flutter/material.dart';
import '../../../core/navigator/navigator.dart';

class VacationRoutes extends IModuleRoutes {
  @override
  String get routeName => '/vacation';

  @override
  Map<String, Widget Function(BuildContext context)> get routes => {
        '/history': (context) => VacationHistoryPage(
              agent: getArgs(context),
            ),
      };
}
