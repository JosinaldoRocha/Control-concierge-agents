import 'package:flutter/material.dart';

enum ScreenTypes {
  mobile,
  tablet,
  pc,
}

class ScreenSize extends StatelessWidget {
  const ScreenSize({
    super.key,
    required this.child,
  });

  final Widget Function(ScreenTypes size) child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final value = width < 480
        ? ScreenTypes.mobile
        : width > 900
            ? ScreenTypes.pc
            : ScreenTypes.tablet;

    return child(value);
  }
}
