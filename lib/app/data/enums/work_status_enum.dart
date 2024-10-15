enum WorkStatus {
  inService,
  isOff,
  isOnVacation;

  String get text {
    switch (this) {
      case WorkStatus.inService:
        return 'Plantão';
      case WorkStatus.isOff:
        return 'Folga';
      case WorkStatus.isOnVacation:
        return 'Férias';
    }
  }

  factory WorkStatus.fromString(String status) {
    if (status == 'Plantão') {
      return WorkStatus.inService;
    } else if (status == 'Folga') {
      return WorkStatus.isOff;
    }
    {
      return WorkStatus.isOnVacation;
    }
  }
}
