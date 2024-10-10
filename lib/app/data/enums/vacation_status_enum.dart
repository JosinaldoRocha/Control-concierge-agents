import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../models/vacation_model.dart';

enum VacationStatus {
  unexpired,
  expired,
  expiring,
  undefined;

  factory VacationStatus.status(VacationModel vacation) {
    DateTime currentDate = DateTime.now();

    if (vacation.vacationExpiration != null) {
      if (vacation.vacationExpiration!.day == currentDate.day &&
          vacation.vacationExpiration!.month == currentDate.month &&
          vacation.vacationExpiration!.year == currentDate.year) {
        return VacationStatus.expiring;
      } else if (vacation.vacationExpiration!.isAfter(currentDate)) {
        return VacationStatus.unexpired;
      } else {
        return VacationStatus.expired;
      }
    } else {
      return VacationStatus.undefined;
    }
  }

  String get text {
    switch (this) {
      case VacationStatus.unexpired:
        return 'À vencer';
      case VacationStatus.expired:
        return 'Vencida';
      case VacationStatus.expiring:
        return 'Vencendo hoje';
      case VacationStatus.undefined:
        return 'À combinar';
    }
  }

  Color get color {
    switch (this) {
      case VacationStatus.unexpired:
        return AppColor.primaryGrey;
      case VacationStatus.expiring:
        return AppColor.primaryGreen;
      case VacationStatus.expired:
        return AppColor.primaryRed;
      default:
        return AppColor.primary;
    }
  }
}
