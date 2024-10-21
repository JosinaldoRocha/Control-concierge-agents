import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/models/vacation_history_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/helpers/errors/errors.dart';

class VacationDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<CommonError, bool>> addVacationHistory({
    required agentId,
    required VacationHistoryModel vacationHistory,
  }) async {
    final agentDoc = FirebaseFirestore.instance
        .collection('concierge-agents')
        .doc(agentId)
        .collection('vacation-history')
        .doc('${vacationHistory.year}${vacationHistory.vestingPeriod}');

    try {
      await agentDoc.set(vacationHistory.toMap());
      return const Right(true);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }

  Future<Either<CommonError, List<VacationHistoryModel>>> getVacationHistory({
    required String agentId,
  }) async {
    try {
      final getDocuments = await _firestore
          .collection('concierge-agents')
          .doc(agentId)
          .collection('vacation-history')
          .orderBy('year', descending: true)
          .get();

      final documents = getDocuments.docs;
      List<VacationHistoryModel> history = [];

      for (var docs in documents) {
        final item = VacationHistoryModel.fromSnapShot(docs);
        history.add(item);
      }

      return Right(history);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }
}
