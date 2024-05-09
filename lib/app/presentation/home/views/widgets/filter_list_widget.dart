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

  final Function(FilterType?, bool isSelected) onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterListWidgetState();
}

class _FilterListWidgetState extends ConsumerState<FilterListWidget> {
  FilterType? selectedFilter;
  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  void selectFilter(FilterType? filter) {
    setState(() {
      selectedFilter = selectedFilter == filter ? null : filter;
    });

    widget.onTap(selectedFilter, selectedFilter == filter);

    scrollToItem();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 16),
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return FilterItemWidget(
            filter: filterList[index],
            isSelected: selectedFilter == filterList[index],
            onTap: () => selectFilter(filterList[index]),
          );
        },
        separatorBuilder: (context, index) => const SpaceHorizontal.x3(),
        itemCount: filterList.length,
      ),
    );
  }

  void scrollToItem() {
    //TODO: resolver bug no último item à direita
    if (selectedFilter != null && scrollController?.hasClients == true) {
      final itemIndex = filterList.indexOf(selectedFilter!);

      if (itemIndex != -1) {
        scrollController!.animateTo(
          itemIndex * 40.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}
