import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../widgets/spacing/space_horizontal_widget.dart';

class FilterListWidget extends ConsumerWidget {
  const FilterListWidget({
    super.key,
    required this.onTap,
  });

  final Function(FilterType) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ButtonWidget(
          width: double.minPositive,
          title: filterList[index].text,
          onTap: () => onTap(filterList[index]),
        ),
        separatorBuilder: (context, index) => const SpaceHorizontal.x3(),
        itemCount: filterList.length,
      ),
    );
  }
}
