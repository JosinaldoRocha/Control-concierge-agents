import 'package:control_concierge_agents/app/presentation/home/provider/home_provider.dart';
import 'package:control_concierge_agents/app/presentation/home/states/agents_list_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/home/views/mixin/home_mixin.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/filter_list_widget.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/select_filter_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../widgets/agent_list_widget.dart';
import '../widgets/agent_search_delegate.dart';
import '../widgets/drawer_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(agentListStateProvider);
    logoutListen();

    return Scaffold(
      appBar: _buildAppBar(context, state),
      body: Column(
        children: [
          FilterListWidget(
            onTap: onTapFilter,
          ),
          if (filterType != null)
            Container(
              width: 300,
              padding: const EdgeInsets.only(top: 16),
              child: SelectFilterOptionWidget(
                filterType: filterType,
                bondTypeController: bondTypeController,
                unitController: unitController,
                workShiftController: workShiftController,
                vacationPayController: vacationPayController,
                onChanged: onChanged,
              ),
            ),
          Expanded(
            child: state.maybeWhen(
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
      ),
      floatingActionButton: _buildFloatingActionButton(context),
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

  AppBar _buildAppBar(BuildContext context, AgentListState state) {
    return AppBar(
      title: const Text('Agentes de portaria SEMED'),
      centerTitle: true,
      leading: GestureDetector(
        child: Icon(Icons.menu_rounded),
        onTap: () => showModalBottomSheet(
          isDismissible: false,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          builder: (context) => DrawerWidget(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            size: 35,
          ),
          onPressed: () {
            showSearch(
              context: context,
              delegate: AgentSearchDelegate(
                list: state.maybeWhen(
                  loadSuccess: (data) => data,
                  orElse: () => [],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(
        Icons.add_rounded,
        size: 40,
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/agent/add');
      },
    );
  }
}
