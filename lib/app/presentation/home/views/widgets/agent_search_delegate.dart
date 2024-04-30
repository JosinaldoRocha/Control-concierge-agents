import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:control_concierge_agents/app/presentation/home/views/widgets/agent_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';

class AgentSearchDelegate extends SearchDelegate {
  final List<AgentModel> list;

  AgentSearchDelegate({required this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: AppColor.white,
        ),
        onPressed: () {
          query.isEmpty ? Navigator.pop(context) : query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context, list);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context, list);
  }

  Widget _buildSearchResults(BuildContext context, List<AgentModel> list) {
    final List<AgentModel> filteredAgents = list.where((agent) {
      return agent.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filteredAgents.isEmpty) {
      return Center(
        child: Text(
          'Nenhum agente encontrado',
          style: AppText.text().bodyMedium!.copyWith(color: AppColor.primary),
        ),
      );
    }

    return AgentListWidget(agents: filteredAgents);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColor.lightBlue,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColor.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
