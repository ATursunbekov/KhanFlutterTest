import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/bloc/calendar_bloc.dart';
import '../../core/bloc/calendar_event.dart';
import '../../core/bloc/calendar_state.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
      ),
      body: Column(
        children: [
          TableCalendar(
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
          ),
          Expanded(
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state is CalendarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CalendarLoaded) {
                  return ListView.builder(
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      final event = state.events[index];
                      return ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.description),
                      );
                    },
                  );
                } else if (state is CalendarError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Select a date range to load events.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
