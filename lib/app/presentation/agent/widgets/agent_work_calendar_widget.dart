import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AgentWorkCalendarWidget extends StatefulWidget {
  final List<DateTime> workDays;

  const AgentWorkCalendarWidget({required this.workDays, Key? key})
      : super(key: key);

  @override
  _AgentCalendarState createState() => _AgentCalendarState();
}

class _AgentCalendarState extends State<AgentWorkCalendarWidget> {
  late Map<DateTime, List> _events;

  @override
  void initState() {
    super.initState();
    _events = _generateEvents(widget.workDays);
  }

  Map<DateTime, List> _generateEvents(List<DateTime> workDays) {
    // Transformando a lista de DateTime em um mapa para o calendário
    Map<DateTime, List> events = {};
    for (var day in workDays) {
      // Normaliza a data para ignorar o horário
      DateTime normalizedDate = DateTime(day.year, day.month, day.day);
      events[normalizedDate] = ['Trabalho'];
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(color: AppColor.primaryRed),
        todayDecoration: BoxDecoration(),
      ),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextFormatter: (date, locale) {
          String formattedDate = DateFormat.yMMMM(locale).format(date);
          return formattedDate[0].toUpperCase() + formattedDate.substring(1);
        },
      ),
      locale: 'pt_BR',
      firstDay: DateTime.utc(DateTime.now().year, 1, 1),
      lastDay: DateTime.utc(DateTime.now().year, 12, 31),
      focusedDay: DateTime.now(),
      eventLoader: (date) {
        return _events[DateTime(date.year, date.month, date.day)] ?? [];
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              bottom: 5,
              child: Icon(
                Icons.circle,
                size: 6,
                color: AppColor.primaryGreen,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
