import 'package:equatable/equatable.dart';
import 'package:pet_app/models/api_response.dart';
import 'package:pet_app/models/event.dart';

abstract class EventState extends Equatable {
  final List<EventModel> events;
  EventState(
    this.events,
    [List props = const []]
  ) : super([events]..addAll(props));
}

class EventEmpty extends EventState {
  EventEmpty() : super([]);

  @override
  String toString() => 'EventEmpty';
}

class EventLoading extends EventState {
  EventLoading() : super(null);

  @override
  String toString() => 'EventLoading';
}

class EventLoaded extends EventState {
  EventLoaded(
    List<EventModel> events,
  ) : super(events);

  @override
  String toString() => 'EventLoaded';
}

class EventLoadFailed extends EventState {
  final APIError error;

  EventLoadFailed({this.error}) : super([], [error]);

  @override
  String toString() => 'EventLoadFailed';
}
