import 'package:control_concierge_agents/app/core/style/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/presentation/home/views/pages/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Agentes de portaria SEMED',
        theme: AppTheme.getTheme(),
        home: const HomePage(),
      ),
    );
  }
}
