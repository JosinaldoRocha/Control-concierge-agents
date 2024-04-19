import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final agents = ['Ronaldo', 'Luiz', 'Sandro', 'Rafael'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agentes de portaria SEMED'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => ElevatedButton(
              onPressed: () {},
              child: Text(
                agents[index],
                style: const TextStyle(color: AppColor.white),
              )),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: agents.length,
        ));
  }
}
