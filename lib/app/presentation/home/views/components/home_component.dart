import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/presentation/home/views/mixin/home_mixin.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/home_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../provider/home_provider.dart';
import '../widgets/agent_list_widget.dart';
import '../widgets/filter_list_widget.dart';
import '../widgets/select_filter_option_widget.dart';

class HomeComponent extends ConsumerStatefulWidget {
  const HomeComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeComponentState();
}

class _HomeComponentState extends ConsumerState<HomeComponent> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    final agentListState = ref.watch(agentListStateProvider);

    deleteAgentListen();

    return Column(
      children: [
        HomeAppBarWidget(),
        agentListState.maybeWhen(
          loadSuccess: (data) {
            return !showFilter
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showFilter = true;
                          });
                        },
                        child: Icon(
                          Icons.filter_list_rounded,
                          color: AppColor.mediumBlue,
                        ),
                      ),
                    ),
                  )
                : FilterListWidget(
                    onTap: onTapFilter,
                  );
          },
          orElse: () => Container(),
        ),
        if (filterType != null)
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              left: 8,
              right: 8,
            ),
            child: SelectFilterOptionWidget(
              filterType: filterType,
              bondTypeController: bondTypeController,
              unitController: unitController,
              workShiftController: workShiftController,
              vacationExpirationController: vacationExpirationController,
              onChanged: onChanged,
            ),
          ),
        Expanded(
          child: agentListState.maybeWhen(
            loadInProgress: () => _buildLoadingIndicator(),
            loadSuccess: (data) {
              return data.isEmpty
                  ? const Center(
                      child: Text('Nenhum agente cadastrado'),
                    )
                  : RefreshIndicator(
                      onRefresh: () async => load(),
                      child: AgentListWidget(
                        agents: data,
                        filterType: filterType,
                        filter: filter,
                      ),
                    );
            },
            loadFailure: (failure) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  'Houve um erro do nosso lado, tente novamente mais tarde!',
                ),
              ),
            ),
            orElse: () => Container(),
          ),
        ),
      ],
    );
  }

  Center _buildLoadingIndicator() {
    return const Center(
      child: SizedBox(
        height: 10,
        width: 80,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
        ),
      ),
    );
  }
}
