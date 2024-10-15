enum AgentStatus {
  isActive,
  isOnLeave,
  isCertified,
  functionDeviation;

  String get text {
    switch (this) {
      case AgentStatus.isActive:
        return 'Ativo';
      case AgentStatus.isOnLeave:
        return 'Em licença';
      case AgentStatus.isCertified:
        return 'Atestado médico';
      case AgentStatus.functionDeviation:
        return 'Desvio de função';
    }
  }
}
