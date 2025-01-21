import 'package:flutter/material.dart';

class NavItem {
  final String title;
  final IconData selectedIcon;
  final IconData icon;

  NavItem({
    required this.title,
    required this.selectedIcon,
    required this.icon,
  });
}
