import '../entities/event_entity.dart';

abstract class EventRepository {
  Future<List<Event>> fetchEvents(DateTime startDate, DateTime endDate);
}
