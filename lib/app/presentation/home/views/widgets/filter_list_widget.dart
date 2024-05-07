import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/filter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../widgets/spacing/space_horizontal_widget.dart';

class FilterListWidget extends ConsumerStatefulWidget {
  const FilterListWidget({
    super.key,
    required this.onTap,
  });

  final Function(FilterType?) onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterListWidgetState();
}

class _FilterListWidgetState extends ConsumerState<FilterListWidget> {
  FilterType? selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FilterItemWidget(
            filter: filterList[index],
            isSelected: selectedFilter == filterList[index],
            onTap: () {
              setState(() {
                if (selectedFilter == filterList[index]) {
                  selectedFilter = null;
                } else {
                  selectedFilter = filterList[index];
                }
              });
              widget.onTap(selectedFilter);
            },
          );
        },
        separatorBuilder: (context, index) => const SpaceHorizontal.x3(),
        itemCount: filterList.length,
      ),
    );
  }
}
