import 'package:control_concierge_agents/app/presentation/authentication/provider/auth_provider.dart';
import 'package:control_concierge_agents/app/presentation/home/views/components/home_component.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../data/enums/filter_type_enum.dart';
import '../../../../widgets/snack_bar/app_snack_bar_widget.dart';
import '../../../agent/provider/agent_provider.dart';
import '../../../agent/states/delete/delete_agent_state_notifier.dart';
import '../../provider/home_provider.dart';

mixin HomeMixin<T extends HomeComponent> on ConsumerState<T> {
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final workShiftController = SingleValueDropDownController();
  final vacationExpirationController = SingleValueDropDownController();

  FilterType? filterType;
  String? filter;
  bool showFilter = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => load());
  }

  deleteAgentListen() {
    ref.listen<DeleteAgentState>(
      deleteAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            ref.read(agentListStateProvider.notifier).load();
            AppSnackBar.show(
              context,
              'Agente excluído com sucesso!',
              AppColor.secondary,
            );
          },
          loadFailure: (message) {
            AppSnackBar.show(
              context,
              'Houve um erro ao excluir o agente. Tente novamente mais tarde!',
              AppColor.error,
            );
          },
          orElse: () {},
        );
      },
    );
  }

  void load() {
    ref.read(agentListStateProvider.notifier).load();
    ref.read(getUserProvider.notifier).load();
  }

  void onChanged(dynamic p0) {
    setState(() {
      if (filterType == FilterType.vacationExpiration) {
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
      showFilter = isSelected;
      filter = null;
    });

    bondTypeController.clearDropDown();
    unitController.clearDropDown();
    workShiftController.clearDropDown();
    vacationExpirationController.clearDropDown();
  }
}
