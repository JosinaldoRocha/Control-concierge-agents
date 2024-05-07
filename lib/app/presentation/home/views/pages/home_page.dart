import 'package:control_concierge_agents/app/data/enums/filter_type_enum.dart';
import 'package:control_concierge_agents/app/presentation/home/provider/home_provider.dart';
import 'package:control_concierge_agents/app/presentation/home/states/agents_list_state_notifier.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/filter_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../widgets/agent_list_widget.dart';
import '../widgets/agent_search_delegate.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  FilterType filter = FilterType.name;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => load());
  }

  void load() {
    ref.read(agentListStateProvider.notifier).load(filter.name);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(agentListStateProvider);

    return Scaffold(
      appBar: _buildAppBar(context, state),
      body: Column(
        children: [
          FilterListWidget(
            onTap: (currentFilter) {
              filter = currentFilter;
              ref
                  .read(agentListStateProvider.notifier)
                  .load(currentFilter.name);
            },
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
                          filter: filter,
                        ),
                      );
              },
              loadFailure: (failure) => const SizedBox(
                child: Text('Ocorreu um erro'),
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
