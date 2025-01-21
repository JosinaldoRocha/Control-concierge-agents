import 'package:control_concierge_agents/app/presentation/agent/views/component/add_edit_agent_component.dart';
import 'package:control_concierge_agents/app/presentation/home/views/components/profile_component.dart';
import 'package:control_concierge_agents/app/presentation/home/views/components/home_component.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/scaffold_side_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/home_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIcon = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(homeTabsProvider.notifier).updateState = 0);
  }

  void listenTab() {
    ref.listen<int>(
      homeTabsProvider,
      (previous, next) {
        setState(() {
          controller.jumpToPage(next);
          selectedIcon = next;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    listenTab();

    return ScaffoldWithSideBarWidget(
      body: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: const [
            HomeComponent(),
            AddEditAgentComponent(),
            ProfileComponent(),
          ],
        ),
      ),
    );
  }
}
