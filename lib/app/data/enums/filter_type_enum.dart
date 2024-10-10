enum FilterType {
  bondType,
  unit,
  workShift,
  vacationExpiration;

  String get text {
    switch (this) {
      case FilterType.bondType:
        return 'Vínculo';
      case FilterType.unit:
        return 'Lotação';
      case FilterType.workShift:
        return 'Turno';
      case FilterType.vacationExpiration:
        return 'Venc. férias';
    }
  }
}
