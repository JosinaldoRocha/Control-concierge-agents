import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/helpers/errors/errors.dart';

class AgentDataSource {
  Future<Either<CommonError, List<AgentModel>>> getAgents() async {
    try {
      return Right(
        [
          AgentModel(
            id: 01,
            name: 'Josinaldo',
            employmentRelationship: 'Contrato',
            unit: 'Esc Dey',
            vacation: 'Não possui',
            phone: '99 99999-9999',
          ),
          AgentModel(
            id: 02,
            name: 'Samuel',
            employmentRelationship: 'Efetivo',
            unit: 'Esc Osvaldo Rodrigues',
            vacation: 'Janeiro',
            phone: '99 99999-9999',
          ),
        ],
      );
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }
}
