import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khan_test_proj/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:khan_test_proj/features/calendar/presentation/bloc/calendar_state.dart';
import '../widgets/calendar_selector.dart';
import '../widgets/event_list_view.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
      ),
      body: Column(
        children: [
          const CalendarSelector(),
          Expanded(
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state is CalendarLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CalendarLoaded) {
                  return EventListView(state: state);
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
