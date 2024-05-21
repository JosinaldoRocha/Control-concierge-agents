import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:control_concierge_agents/app/presentation/authentication/states/logout/logout_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/home/views/pages/home_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../data/enums/filter_type_enum.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../provider/home_provider.dart';

mixin HomeMixin<T extends HomePage> on ConsumerState<T> {
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final workShiftController = SingleValueDropDownController();
  final vacationPayController = SingleValueDropDownController();

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

  void logoutListen() {
    ref.listen<LogoutState>(
      logoutProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) =>
              Navigator.of(context).pushReplacementNamed('/auth'),
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Não foi possível sair do app. Tente novamente!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void onChanged(dynamic p0) {
    setState(() {
      if (filterType == FilterType.vacationPay) {
        filter = (p0.value.index + 1).toString();
      } else {
        filter = p0.name;
      }
    });

    print('Filtro $filter');
  }

  void onTapFilter(currentFilter, isSelected) {
    setState(() {
      filterType = isSelected ? currentFilter : null;

      filter = null;
    });

    bondTypeController.clearDropDown();
    unitController.clearDropDown();
    workShiftController.clearDropDown();
    vacationPayController.clearDropDown();
  }
}
