import 'package:cached_network_image/cached_network_image.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_details_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_work_calendar_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/vacation_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../data/models/agent_model.dart';

class AgentDetailsPage extends ConsumerWidget {
  const AgentDetailsPage({
    super.key,
    required this.agent,
  });
  final AgentModel agent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      body: Stack(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: agent.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: agent.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: 20,
                        width: 130,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulse,
                        ),
                      ),
                    ),
                  )
                : Image.asset('assets/images/profile.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 12,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                style: IconButton.styleFrom(
                  shape: OvalBorder(),
                  backgroundColor: Color(0x2EEDF4F7),
                ),
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColor.primary,
                ),
              ),
            ),
          ),
          Positioned(
            top: 270,
            child: Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height - 254,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColor.bgColor,
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    AgentDetailsWidget(agent: agent),
                    _buildExpansionTile(
                      'FÉRIAS',
                      [
                        agent.bondType == BondTypeEnum.effective
                            ? VacationDetailsWidget(agent: agent)
                            : Text('Férias indisponível'),
                      ],
                    ),
                    _buildExpansionTile(
                      'ESCALA',
                      [
                        AgentWorkCalendarWidget(workDays: agent.workScale),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/agent/edit',
            arguments: agent,
          );
        },
        child: SvgPicture.asset(
          height: 40,
          'assets/icons/edit.svg',
          colorFilter: const ColorFilter.mode(
            AppColor.primary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildExpansionTile(String title, List<Widget> itens) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(bottom: 12),
      initiallyExpanded: false,
      shape: Border(),
      visualDensity: VisualDensity.compact,
      iconColor: AppColor.primary,
      title: Text(
        title,
        style: AppText.text().bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColor.primary,
            ),
      ),
      children: itens,
    );
  }
}

//                       ButtonWidget(
//                         isLoading: state is CommonStateLoadInProgress,
//                         trailing: const Icon(Icons.delete),
//                         color: AppColor.primaryRed,
//                         height: 40,
//                         width: double.minPositive,
//                         title: 'Excluir',
//                         onTap: () {
//                           showModalBottomSheet(
//                             isDismissible: false,
//                             context: context,
//                             builder: (context) => AgentModalWidget(
//                               title:
//                                   'Tem certeza que quer deletar esse agente?',
//                               description:
//                                   'Ao deletar um agente você não poderá recupar seus dados',
//                               confirmTitle: 'Sim',
//                               onConfirm: () {
//                                 ref
//                                     .read(deleteAgentStateProvider.notifier)
//                                     .delete(agent.id);
//                                 Navigator.pop(context);
//                               },
//                               cancelTitle: 'Cancelar',
//                               onCancel: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
