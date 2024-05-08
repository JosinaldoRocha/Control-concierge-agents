import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/constants.dart';
import 'filter_option_dropdown_widget.dart';

class SelectFilterOptionWidget extends StatelessWidget {
  const SelectFilterOptionWidget({
    super.key,
    required this.filterType,
    required this.bondTypeController,
    required this.unitController,
    required this.workShiftController,
    required this.onChanged,
  });
  final FilterType? filterType;
  final SingleValueDropDownController bondTypeController;
  final SingleValueDropDownController unitController;
  final SingleValueDropDownController workShiftController;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    if (filterType! == FilterType.bondType) {
      return FilterOptionDropdownWidget(
        controller: bondTypeController,
        list: bondTypeList,
        hintText: 'Selecione o vínculo',
        onChanged: onChanged,
      );
    } else if (filterType! == FilterType.unit) {
      return FilterOptionDropdownWidget(
        controller: unitController,
        list: unitList,
        hintText: 'Selecione a lotação',
        listPadding: ListPadding(top: 5, bottom: 5),
        onChanged: onChanged,
      );
    } else if (filterType! == FilterType.workShift) {
      return FilterOptionDropdownWidget(
        controller: workShiftController,
        list: workShiftList,
        hintText: 'Selecione o turno',
        onChanged: onChanged,
      );
    } else {
      return Container();
    }
  }
}
