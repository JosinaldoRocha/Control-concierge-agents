import '../models/vacation_model.dart';

enum AgentStatus {
  isActive,
  isInactive,
  isOnLeave,
  isOnVacation,
  other;

  factory AgentStatus.isOnVacationFromDate(VacationModel? vacation) {
    final currentDate = DateTime.now();

    final startVacation = vacation?.startVacation;
    final endVacation = vacation?.endVacation;

    bool isAtSameMomentAs(DateTime? date) {
      return date?.day == currentDate.day &&
              date?.month == currentDate.month &&
              date?.year == currentDate.year
          ? true
          : false;
    }

    if (startVacation != null && endVacation != null) {
      if ((startVacation.isBefore(currentDate) ||
              isAtSameMomentAs(startVacation)) &&
          (endVacation.isAfter(currentDate) || isAtSameMomentAs(endVacation))) {
        return AgentStatus.isOnVacation;
      } else {
        return AgentStatus.other;
      }
    } else {
      return AgentStatus.other;
    }
  }
}
