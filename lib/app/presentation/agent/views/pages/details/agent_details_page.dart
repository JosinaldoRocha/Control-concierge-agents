import 'package:control_concierge_agents/app/core/helpers/helpers.dart';
import 'package:control_concierge_agents/app/presentation/agent/provider/agent_provider.dart';
import 'package:control_concierge_agents/app/presentation/agent/states/delete/delete_agent_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_details_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/header_agent_details_widget.dart';
import 'package:control_concierge_agents/app/widgets/modal/agent_modal_widget.dart';
import 'package:control_concierge_agents/app/presentation/home/provider/home_provider.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/space_horizontal_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../data/models/agent_model.dart';
import '../../../../../widgets/snack_bar/app_snack_bar_widget.dart';

class AgentDetailsPage extends ConsumerWidget {
  const AgentDetailsPage({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deleteAgentStateProvider);

    ref.listen<DeleteAgentState>(
      deleteAgentStateProvider,
      (previous, next) {
        next.maybeWhen(
          loadSuccess: (data) {
            ref.read(agentListStateProvider.notifier).load();
            Navigator.pop(context);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          const SpaceVertical.x4(),
          HeaderAgentDetailsWidget(agent: agent),
          const SpaceVertical.x8(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColor.white,
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                children: [
                  AgentDetailsWidget(agent: agent),
                  const SpaceVertical.x5(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(
                        height: 40,
                        width: double.minPositive,
                        title: 'Editar',
                        trailing: const Icon(Icons.edit_outlined),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/agent/edit',
                            arguments: agent,
                          );
                        },
                      ),
                      const SpaceHorizontal.x4(),
                      ButtonWidget(
                        isLoading: state is CommonStateLoadInProgress,
                        trailing: const Icon(Icons.delete),
                        color: AppColor.primaryRed,
                        height: 40,
                        width: double.minPositive,
                        title: 'Excluir',
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (context) => AgentModalWidget(
                              title:
                                  'Tem certeza que quer deletar esse agente?',
                              description:
                                  'Ao deletar um agente você não poderá recupar seus dados',
                              confirmTitle: 'Sim',
                              onConfirm: () {
                                ref
                                    .read(deleteAgentStateProvider.notifier)
                                    .delete(agent.id);
                                Navigator.pop(context);
                              },
                              cancelTitle: 'Cancelar',
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
