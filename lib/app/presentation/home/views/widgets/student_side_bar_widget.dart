import 'package:control_concierge_agents/app/core/constants/constants.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/user_profile_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../core/customer/nav_item.dart';
import '../../../../core/style/app_colors.dart';
import '../../provider/home_provider.dart';

class StudentSideBarWidget extends ConsumerWidget {
  const StudentSideBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeTabsProvider);
    final items = navItems;

    return Container(
      width: 80,
      margin: const EdgeInsets.all(20).copyWith(
        right: 20,
        bottom: MediaQuery.sizeOf(context).height * .3,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColor.bgColor,
      ),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              items.length,
              (index) =>
                  sideBarItem(items[index], currentIndex == index, index, ref),
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserProfileWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget sideBarItem(NavItem item, bool isSelected, int index, WidgetRef ref) {
    return Container(
      height: 48,
      width: 48,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.cardBackground : null,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        style: IconButton.styleFrom(),
        icon: Icon(item.selectedIcon),
        color: isSelected ? AppColor.mediumBlue : AppColor.white,
        onPressed: () {
          ref.read(homeTabsProvider.notifier).updateState = index;
        },
      ),
    );
  }
}
