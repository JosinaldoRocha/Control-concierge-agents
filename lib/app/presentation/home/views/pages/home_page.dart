import 'package:control_concierge_agents/app/presentation/home/provider/agent_provider.dart';
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
    Future.microtask(() => ref.read(agentListStateProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(agentListStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agentes de portaria SEMED'),
      ),
      body: state.maybeWhen(
        loadInProgress: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loadSuccess: (data) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) => ElevatedButton(
              onPressed: () {},
              child: Text(data[index].name),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemCount: data.length,
          );
        },
        loadFailure: (failure) => const SizedBox(
          child: Text('Ocorreu um erro'),
        ),
        orElse: () => Container(),
      ),
    );
  }
}
