import 'package:equatable/equatable.dart';
// Models
import 'package:pet_app/models/event.dart';

abstract class EventEvent extends Equatable {
  EventEvent([List props = const []]) : super(props);
}

class EventLoad extends EventEvent {
  EventLoad() : super();
  
  @override
  String toString() => 'EventLoad';
}

class EventRefresh extends EventEvent{
  final List<EventModel> events;

  EventRefresh(
    this.events
  ) : super([events]);
  
  @override
  String toString() => 'EventRefresh';
}
/*
class EventFilter extends EventEvent {
  final MapFilter filter;
  EventFilter({this.filter}) : super([filter]);
  
  @override
  String toString() => 'MapFilter';
}
*/