import 'package:flutter/material.dart';
import 'package:khan_test_proj/features/calendar/presentation/bloc/calendar_state.dart';

class EventListView extends StatelessWidget {
  final CalendarLoaded state;

  const EventListView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
