import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_test_proj/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:khan_test_proj/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarSelector extends StatefulWidget {
  const CalendarSelector({super.key});

  @override
  State<CalendarSelector> createState() => _CalendarSelectorState();
}

class _CalendarSelectorState extends State<CalendarSelector> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          if (_startDate == null || (_startDate != null && _endDate != null)) {
            _startDate = selectedDay;
            _endDate = null;
          } else if (_startDate != null && _endDate == null) {
            if (selectedDay.isAfter(_startDate!)) {
              _endDate = selectedDay;
              final difference = _endDate!.difference(_startDate!).inDays;
              if (difference < 7) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a range of at least 7 days.')),
                );
                _startDate = null;
                _endDate = null;
              } else {
                context.read<CalendarBloc>().add(
                      LoadEvents(startDate: _startDate!, endDate: _endDate!),
                    );
              }
            } else {
              _startDate = selectedDay;
            }
          }
        });
      },
      selectedDayPredicate: (day) {
        if (_startDate != null && _endDate != null) {
          return day.isAfter(_startDate!.subtract(const Duration(days: 1))) &&
              day.isBefore(_endDate!.add(const Duration(days: 1)));
        } else if (_startDate != null) {
          return isSameDay(day, _startDate!);
        }
        return false;
      },
    );
  }
}
