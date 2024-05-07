import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:flutter/material.dart';
import '../../../../core/style/app_colors.dart';

class FilterItemWidget extends StatelessWidget {
  const FilterItemWidget({
    super.key,
    required this.filter,
    required this.onTap,
    required this.isSelected,
  });

  final FilterType filter;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: isSelected ? AppColor.secondary : AppColor.primary,
      ),
      onPressed: onTap,
      child: Text(filter.text),
    );
  }
}
