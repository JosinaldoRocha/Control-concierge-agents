import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/customer/nav_item.dart';

class BottomBarWidget extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<NavItem> items;
  final int selectedIndex;

  const BottomBarWidget({
    required this.onTabSelected,
    required this.items,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: BottomNavigationBar(
        onTap: widget.onTabSelected,
        currentIndex: widget.selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        selectedLabelStyle: AppText.text().bodyMedium?.copyWith(height: 2),
        showUnselectedLabels: true,
        unselectedFontSize: 10,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.cardBackground,
        unselectedLabelStyle: AppText.text().bodySmall?.copyWith(
              height: 2,
            ),
        enableFeedback: true,
        backgroundColor: AppColor.bgColor,
        items: widget.items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Icon(
                    widget.selectedIndex == widget.items.indexOf(item)
                        ? item.selectedIcon
                        : item.icon,
                    color: widget.selectedIndex == widget.items.indexOf(item)
                        ? AppColor.primary
                        : AppColor.cardBackground,
                  ),
                ),
                label: item.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
