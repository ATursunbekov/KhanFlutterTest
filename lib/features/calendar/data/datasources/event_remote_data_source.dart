import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/event_entity.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<Event>> getEvents(DateTime startDate, DateTime endDate);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final http.Client client;

  EventRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Event>> getEvents(DateTime startDate, DateTime endDate) async {
    String formatDate(DateTime date) {
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    }

    final uri = Uri.parse('https://test-task-app-alpha.vercel.app/api/test-task').replace(
      queryParameters: {
        'start_date': formatDate(startDate),
        'end_date': formatDate(endDate),
      },
    );

    try {
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => EventModel.fromJson(json)).toList();
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch events: $e');
    }
  }
}
