import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/calendar/data/datasources/event_remote_data_source.dart';
import 'features/calendar/data/repositories/event_repository_impl.dart';
import 'features/calendar/domain/usecases/get_events.dart';
import 'features/calendar/core/bloc/calendar_bloc.dart';
import 'features/calendar/presentation/pages/calendar_page.dart';

void main() {
  final client = http.Client();
  final dataSource = EventRemoteDataSourceImpl(client: client);
  final repository = EventRepositoryImpl(remoteDataSource: dataSource);
  final getEvents = GetEvents(repository);

  runApp(MyApp(getEvents: getEvents));
}

class MyApp extends StatelessWidget {
  final GetEvents getEvents;

  const MyApp({Key? key, required this.getEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => CalendarBloc(getEvents: getEvents),
        child: const CalendarPage(),
      ),
    );
  }
}
