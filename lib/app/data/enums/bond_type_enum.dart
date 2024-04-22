enum BondTypeEnum {
  effective,
  contract;

  factory BondTypeEnum.fromString(String type) {
    if (type == 'Concursado') {
      return BondTypeEnum.effective;
    } else {
      return BondTypeEnum.contract;
    }
  }

  String get text {
    switch (this) {
      case BondTypeEnum.effective:
        return 'Concursado';
      case BondTypeEnum.contract:
        return 'Contratado';
    }
  }
}
