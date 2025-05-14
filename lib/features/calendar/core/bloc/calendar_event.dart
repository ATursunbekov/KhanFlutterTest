import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends CalendarEvent {
  final DateTime startDate;
  final DateTime endDate;

  const LoadEvents({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}
