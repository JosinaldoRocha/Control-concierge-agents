import 'package:control_concierge_agents/app/presentation/home/provider/home_provider.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/agent_item_widget.dart';
import 'package:control_concierge_agents/app/widgets/spacing/vertical_space_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) => AgentItemWidget(
                      agent: data[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SpaceVertical.x3(),
                    //TODO: Ajustar espaço entre os itens
                    itemCount: data.length,
                  ),
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
