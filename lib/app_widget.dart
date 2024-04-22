import 'package:control_concierge_agents/app/app_routes.dart';
import 'package:control_concierge_agents/app/core/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agentes de portaria SEMED',
        theme: AppTheme.getTheme(),
        initialRoute: AppRoutes().initialRoute,
        routes: AppRoutes().allAppRoutes,
      ),
    );
  }
}
