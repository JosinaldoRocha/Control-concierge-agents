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

  var bondType = BondTypeEnum.effective;
  int monthIndex = 1;

  Future<DateTime?> _buildShowDatePicker(int month) {
    return showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year, month),
      firstDate: DateTime(DateTime.now().year, month - 1),
      lastDate: DateTime(DateTime.now().year, month + 1),
    );
  }

  Future<void> selectStartVacation() async {
    final DateTime? picked = await _buildShowDatePicker(monthIndex);

    if (picked != null && picked != startVacation) {
      setState(() {
        startVacation = picked;
      });
    }
  }

  Future<void> selectEndVacation() async {
    final DateTime? picked = await _buildShowDatePicker(monthIndex);

    if (picked != null && picked != endVacation) {
      setState(() {
        endVacation = picked;
      });
    }
  }

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