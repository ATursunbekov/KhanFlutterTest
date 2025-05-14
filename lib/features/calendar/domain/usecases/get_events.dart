import '../entities/event.dart';
import '../repositories/event_repository.dart';

class GetEvents {
  final EventRepository repository;

  GetEvents(this.repository);

  Future<List<Event>> call(DateTime startDate, DateTime endDate) {
    return repository.fetchEvents(startDate, endDate);
  }
}
