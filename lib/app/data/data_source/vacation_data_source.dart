import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/models/vacation_history_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/helpers/errors/errors.dart';
import '../models/agent_model.dart';
import '../models/vacation_model.dart';

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

  void checkAndUpdateVacationData() async {
    final currentDate = DateTime.now();

    final _collection = _firestore.collection('concierge-agents');

    final agentsSnapshot = await _collection.get();

    final documents = agentsSnapshot.docs;

    for (var doc in documents) {
      final agent = AgentModel.fromSnapShot(doc);
      final vacation = agent.vacation;

      if (vacation != null) {
        final vacationExpiration = vacation.vacationExpiration;
        final endVacation = vacation.endVacation;
        final startVacation = vacation.startVacation;

        if (vacationExpiration != null &&
            startVacation != null &&
            endVacation != null) {
          DateTime? newVacationExpiration;

          if (endVacation.day == currentDate.day &&
              endVacation.month == currentDate.month &&
              endVacation.year == currentDate.year) {
            final currentYear = DateTime.now().year;

            final vacationHistory = VacationHistoryModel(
              id: '${currentYear}${vacationExpiration.year - 1}-${vacationExpiration.year}',
              year: currentYear,
              vestingPeriod:
                  '${vacationExpiration.year - 1}-${vacationExpiration.year}',
              startDate: startVacation,
              endDate: endVacation,
              vacationExpiration: vacationExpiration,
            );

            await addVacationHistory(
              agentId: agent.id,
              vacationHistory: vacationHistory,
            );
          }

          if (vacationExpiration.isBefore(currentDate) &&
              endVacation.isBefore(currentDate)) {
            newVacationExpiration = DateTime(
              vacationExpiration.year + 1,
              vacationExpiration.month,
              vacationExpiration.day,
            );

            final updatedAgent = agent.copyWith(
              vacation: VacationModel(
                vacationExpiration: newVacationExpiration,
                startVacation: null,
                endVacation: null,
                vacationMonth: null,
                vestingPeriod:
                    '${newVacationExpiration.year - 1}-${newVacationExpiration.year}',
              ),
            );

            await _collection.doc(agent.id).update(updatedAgent.toMap());
          }
        }
      }
    }
  }
}
