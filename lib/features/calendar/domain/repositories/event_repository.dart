import '../entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents(DateTime startDate, DateTime endDate);
}
