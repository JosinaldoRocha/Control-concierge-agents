import 'package:control_concierge_agents/app/core/style/app_text.dart';
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Text(
          filter.text,
          style: AppText.text().bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColor.error : AppColor.black,
              ),
        ),
      ),
    );
  }
}
