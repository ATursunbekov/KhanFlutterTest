import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_data_source.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Event>> fetchEvents(DateTime startDate, DateTime endDate) {
    return remoteDataSource.getEvents(startDate, endDate);
  }
}
