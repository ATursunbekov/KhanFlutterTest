import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_events.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetEvents getEvents;

  CalendarBloc({required this.getEvents}) : super(CalendarInitial()) {
    on<LoadEvents>((event, emit) async {
      emit(CalendarLoading());
      try {
        final events = await getEvents(event.startDate, event.endDate);
        emit(CalendarLoaded(events: events));
      } catch (e) {
        emit(CalendarError(message: e.toString()));
      }
    });
  }
}
