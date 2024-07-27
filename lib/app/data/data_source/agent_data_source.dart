import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../core/helpers/errors/errors.dart';

class AgentDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<CommonError, List<AgentModel>>> getAgents() async {
    try {
      final getDocuments =
          await _firestore.collection('concierge-agents').orderBy('name').get();
      final documents = getDocuments.docs;
      List<AgentModel> agents = [];

      for (var docs in documents) {
        final item = AgentModel.fromSnapShot(docs);
        agents.add(item);
      }

      return Right(agents);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }

  Future<Either<CommonError, bool>> addAgent(AgentModel agent) async {
    try {
      if (agent.imageUrl != null && agent.imageUrl!.isNotEmpty) {
        if (!agent.imageUrl!.contains(agent.id)) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('agent_images')
              .child('${agent.id}.jpg');
          final uploadTask = storageRef.putFile(File(agent.imageUrl!));
          final TaskSnapshot downloadUrl = (await uploadTask);
          final String imageUrl = await downloadUrl.ref.getDownloadURL();

          agent.imageUrl = imageUrl;
        }
      }

      await _firestore
          .collection('concierge-agents')
          .doc(agent.id)
          .set(agent.toMap());
      return const Right(true);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }

  Future<Either<CommonError, bool>> deleteAgent(String agentId) async {
    try {
      await _firestore.collection('concierge-agents').doc(agentId).delete();
      return const Right(true);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }
}
