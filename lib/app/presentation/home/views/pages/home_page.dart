import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:control_concierge_agents/app/presentation/agent/views/component/add_edit_agent_component.dart';
import 'package:control_concierge_agents/app/presentation/home/views/components/profile_component.dart';
import 'package:control_concierge_agents/app/presentation/home/views/components/home_component.dart';
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

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: const [
          HomeComponent(),
          AddEditAgentComponent(),
          ProfileComponent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildBottomBarItem(0, Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomBarItem(1, Icons.add_rounded),
            label: 'Adicionar Agente',
          ),
          BottomNavigationBarItem(
            icon: _buildBottomBarItem(2, Icons.person_2_rounded),
            label: 'Perfil',
          ),
        ],
        elevation: 0,
        currentIndex: selectedIcon,
        backgroundColor: AppColor.bgColor,
        selectedLabelStyle: AppText.text().bodyMedium,
        selectedIconTheme: IconThemeData(color: AppColor.white),
        onTap: (index) {
          ref.read(homeTabsProvider.notifier).updateState = index;
        },
        iconSize: 26,
      ),
    );
  }

  Container _buildBottomBarItem(
    int index,
    IconData icon,
  ) {
    return Container(
      height: 44,
      width: 44,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color:
            selectedIcon == index ? AppColor.lightPurple : AppColor.lightBlue,
        shape: BoxShape.circle,
      ),
      child: Icon(icon),
    );
  }
}
