import '../../domain/entities/event_entity.dart';

class EventModel extends Event {
  const EventModel({
    required String title,
    required String description,
    required DateTime date,
  }) : super(title: title, description: description, date: date);

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final dateParts = json['date'].split('-');
    final parsedDate = DateTime(
      int.parse(dateParts[2]),
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
    );

    return EventModel(
      title: json['event_name'],
      description: json['description'],
      date: parsedDate,
    );
  }
}
