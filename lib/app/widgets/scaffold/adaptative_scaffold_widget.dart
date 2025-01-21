import 'package:flutter/material.dart';

class AdaptativeWidget extends StatelessWidget {
  const AdaptativeWidget({
    super.key,
    required this.body,
  });

  final Widget Function(bool isBig) body;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Center(
      child: SizedBox(
        width: width <= 480 ? double.maxFinite : 480,
        child: body(width > 480),
      ),
    );
  }
}
