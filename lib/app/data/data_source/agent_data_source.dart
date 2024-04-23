import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_concierge_agents/app/data/enums/bond_type_enum.dart';
import 'package:control_concierge_agents/app/data/models/agent_model.dart';
import 'package:dartz/dartz.dart';
import '../../core/helpers/errors/errors.dart';

class AgentDataSource {
  final _firestore = FirebaseFirestore.instance;

  Future<Either<CommonError, List<AgentModel>>> getAgents() async {
    try {
      return Right(
        [
          AgentModel(
            id: '01',
            name: 'Josinaldo',
            bondType: BondTypeEnum.effective,
            unit: 'Esc Dey',
            vacationMonth: 'Não possui',
            phone: '99 99999-9999',
          ),
          AgentModel(
            id: '02',
            name: 'Samuel',
            bondType: BondTypeEnum.contract,
            unit: 'Esc Osvaldo Rodrigues',
            vacationMonth: 'Janeiro',
            phone: '99 99999-9999',
          ),
        ],
      );
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }

  Future<Either<CommonError, bool>> addAgent(AgentModel agent) async {
    try {
      await _firestore
          .collection('concierge-agents')
          .doc(agent.id.toString())
          .set(agent.toMap());
      return const Right(true);
    } on Exception catch (e) {
      return Left(GenerateError.fromException(e));
    }
  }
}
