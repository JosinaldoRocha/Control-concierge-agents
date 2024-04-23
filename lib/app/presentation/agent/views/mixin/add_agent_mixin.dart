import 'package:control_concierge_agents/app/presentation/agent/views/pages/add/add_agent_page.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/enums/bond_type_enum.dart';
import '../../provider/agent_provider.dart';
import '../../states/add_agent_state_notifier.dart';

mixin AddAgentMixin<T extends AddAgentPage> on ConsumerState<T> {
  final nameController = TextEditingController();
  final bondTypeController = SingleValueDropDownController();
  final unitController = SingleValueDropDownController();
  final phoneNumberController = TextEditingController();
  final vacacionMonthContoller = SingleValueDropDownController();
  final observationsController = TextEditingController();
  final forKey = GlobalKey<FormState>();

  DateTime? startVacation;
  DateTime? endVacation;

  Future<void> selectStartVacation() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startVacation,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year, 12),
    );

    if (picked != null && picked != startVacation) {
      setState(() {
        startVacation = picked;
      });
    }
  }

  Future<void> selectEndVacation() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endVacation,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year + 1, 1),
    );

    if (picked != null && picked != endVacation) {
      setState(() {
        endVacation = picked;
      });
    }
  }

  var bondType = BondTypeEnum.effective;

  void addAgentListen() {
    ref.listen<AddAgentState>(
      addAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            Navigator.of(context).pushNamed('/home');
          },
          loadFailure: (message) {},
          orElse: () {},
        );
      },
    );
  }
}
