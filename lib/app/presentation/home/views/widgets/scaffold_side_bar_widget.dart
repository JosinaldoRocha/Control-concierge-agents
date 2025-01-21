import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../widgets/scaffold/screen_size_widget.dart';
import '../../provider/home_provider.dart';
import 'custom_bottom_navigator_widget.dart';
import 'student_side_bar_widget.dart';

class ScaffoldWithSideBarWidget extends ConsumerWidget {
  const ScaffoldWithSideBarWidget({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = navItems;
    final currentIndex = ref.watch(homeTabsProvider);

    return ScreenSize(
      child: (size) => Scaffold(
        extendBody: true,
        backgroundColor: AppColor.cardBackground,
        bottomNavigationBar: size != ScreenTypes.pc
            ? BottomBarWidget(
                items: [
                  ...List.generate(
                    items.length,
                    (index) => items[index],
                  ),
                ],
                selectedIndex: currentIndex,
                onTabSelected: (value) {
                  ref.read(homeTabsProvider.notifier).updateState = value;
                },
              )
            : Container(),
        body: size == ScreenTypes.pc
            ? Row(
                children: [
                  const StudentSideBarWidget(),
                  Expanded(child: body),
                ],
              )
            : body,
      ),
    );
  }
}
