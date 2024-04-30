import 'package:control_concierge_agents/app/presentation/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/agent_list_widget.dart';
import '../widgets/agent_search_delegate.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => load());
  }

  void load() {
    ref.read(agentListStateProvider.notifier).load();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(agentListStateProvider);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: state.maybeWhen(
        loadInProgress: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loadSuccess: (data) {
          return data.isEmpty
              ? const Center(
                  child: Text('Nenhum agente cadastrado'),
                )
              : RefreshIndicator(
                  onRefresh: () async => load(),
                  child: AgentListWidget(agents: data),
                );
        },
        loadFailure: (failure) => const SizedBox(
          child: Text('Ocorreu um erro'),
        ),
        orElse: () => Container(),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
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
