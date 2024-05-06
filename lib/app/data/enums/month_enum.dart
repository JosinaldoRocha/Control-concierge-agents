enum MonthEnum {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  factory MonthEnum.fromInt(int index) {
    return MonthEnum.values.firstWhere((element) => element.index == index - 1);
  }

  String get text {
    switch (this) {
      case MonthEnum.january:
        return 'Janeiro';
      case MonthEnum.february:
        return 'Fevereiro';
      case MonthEnum.march:
        return 'Março';
      case MonthEnum.april:
        return 'Abril';
      case MonthEnum.may:
        return 'Maio';
      case MonthEnum.june:
        return 'Junho';
      case MonthEnum.july:
        return 'Julho';
      case MonthEnum.august:
        return 'Agosto';
      case MonthEnum.september:
        return 'Setembro';
      case MonthEnum.october:
        return 'Outubro';
      case MonthEnum.november:
        return 'Novembro';
      case MonthEnum.december:
        return 'Dezembro';
    }
  }
}
