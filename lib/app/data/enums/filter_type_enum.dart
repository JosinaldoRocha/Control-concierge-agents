enum FilterType {
  name,
  bondType,
  unit,
  workShift;

  String get text {
    switch (this) {
      case FilterType.name:
        return 'Nome';
      case FilterType.bondType:
        return 'Vínculo';
      case FilterType.unit:
        return 'Lotação';
      case FilterType.workShift:
        return 'Turno';
    }
  }
}
