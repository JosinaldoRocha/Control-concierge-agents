import 'package:control_concierge_agents/app/presentation/home/views/pages/home_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/enums/filter_type_enum.dart';
import '../../provider/home_provider.dart';

mixin HomeMixin<T extends HomePage> on ConsumerState<T> {
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final workShiftController = SingleValueDropDownController();

  FilterType? filterType;
  String? filter;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => load());
  }

  void load() {
    ref.read(agentListStateProvider.notifier).load();
  }

  void onChanged(dynamic p0) {
    setState(() => filter = p0.name);
  }

  void onTapFilter(currentFilter, isSelected) {
    setState(() {
      filterType = isSelected ? currentFilter : null;

      filter = null;
    });

    bondTypeController.clearDropDown();
    unitController.clearDropDown();
    workShiftController.clearDropDown();
  }
}
