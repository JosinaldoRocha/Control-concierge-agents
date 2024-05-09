enum FilterType {
  bondType,
  unit,
  workShift,
  vacationPay;

  String get text {
    switch (this) {
      case FilterType.bondType:
        return 'Vínculo';
      case FilterType.unit:
        return 'Lotação';
      case FilterType.workShift:
        return 'Turno';
      case FilterType.vacationPay:
        return 'Venc. férias';
    }
  }
}
