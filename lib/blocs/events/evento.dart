import 'package:equatable/equatable.dart';
// Models
import 'package:pet_app/models/evento.dart';

abstract class EventoEvent extends Equatable {
  EventoEvent([List props = const []]) : super(props);
}

class EventoLoad extends EventoEvent {
  EventoLoad() : super();
  
  @override
  String toString() => 'EventoLoad';
}

class EventoRefresh extends EventoEvent{
  final List<EventoModel> events;

  EventoRefresh(
    this.events
  ) : super([events]);
  
  @override
  String toString() => 'EventoRefresh';
}
/*
class EventFilter extends EventoEvent {
  final MapFilter filter;
  EventFilter({this.filter}) : super([filter]);
  
  @override
  String toString() => 'MapFilter';
}
*/