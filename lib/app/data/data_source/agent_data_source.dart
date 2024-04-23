import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/helpers/errors/errors.dart';

class AgentDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<CommonError, List<AgentModel>>> getAgents() async {
    try {
      final getDocuments =
          await _firestore.collection('concierge-agents').get();
      final documents = getDocuments.docs;
      List<AgentModel> agents = [];

      for (var docs in documents) {
        final item = AgentModel.fromSnapShot(docs);
        agents.add(item);
      }
      agents.sort((a, b) => a.name.compareTo(b.name));

      return Right(agents);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }

  Future<Either<CommonError, bool>> addAgent(AgentModel agent) async {
    try {
      await _firestore
          .collection('concierge-agents')
          .doc(agent.id)
          .set(agent.toMap());
      return const Right(true);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }
}
