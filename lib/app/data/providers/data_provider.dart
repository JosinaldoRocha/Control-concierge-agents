import 'package:control_concierge_agents/app/data/data_source/agent_data_source.dart';
import 'package:control_concierge_agents/app/data/data_source/auth_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final agentDataSourceProvider = Provider(
  (ref) => AgentDataSource(),
);

final authDataSourceProvider = Provider(
  (ref) => AuthDataSource(),
);
