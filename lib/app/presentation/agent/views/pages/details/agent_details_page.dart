import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/vacation/views/widgets/add_vacation_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_details_widget.dart';
import 'package:control_concierge_agents/app/presentation/agent/widgets/agent_work_calendar_widget.dart';
import 'package:control_concierge_agents/app/presentation/vacation/views/widgets/vacation_details_widget.dart';
import 'package:control_concierge_agents/app/widgets/button/button_widget.dart';
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
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: SizedBox(
                            height: 10,
                            width: 48,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballPulse,
                            ),
                          ),
                        ),
                      ),
                      Image.network(
                        agent.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 60);
                        },
                      ),
                    ],
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
                          ? agent.vacation != null
                              ? VacationDetailsWidget(agent: agent)
                              : _buildAddVacationButton(context)
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

  ButtonWidget _buildAddVacationButton(BuildContext context) {
    return ButtonWidget(
      width: 150,
      height: 40,
      title: 'Adicionar férias',
      onTap: () {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (context) => AddVacationWidget(agent: agent),
        );
      },
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
