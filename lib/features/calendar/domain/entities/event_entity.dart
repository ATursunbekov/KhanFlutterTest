import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String title;
  final String description;
  final DateTime date;

  const Event({
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  List<Object> get props => [title, description, date];
}
