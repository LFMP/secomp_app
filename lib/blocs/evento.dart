// Exports
export 'package:pet_app/blocs/events/evento.dart';
export 'package:pet_app/blocs/states/evento.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/events/evento.dart';
import 'package:pet_app/blocs/states/evento.dart';
import 'package:pet_app/models/api_response.dart';
// Repository
import 'package:pet_app/repositories/event_repository.dart';
// Models
import 'package:pet_app/models/evento.dart';

class EventoBloc extends Bloc<EventoEvent, EventoState>{

  final AuthBloc authBloc;

  EventoBloc({this.authBloc});

  @override
  EventoState get initialState => EventoEmpty();

  List<EventoModel> get currentEvents => currentState.events;
  
  // MapFilter get currentFilter => currentState.filter;

  @override
  Stream<EventoState> mapEventToState(EventoEvent event) async* {

    if (event is EventoLoad) {
      yield EventoLoading();
      
      final events = await EventRepository.fetchEvents(authBloc.token);
      
      if (events.isSucessfull)
        yield EventoLoaded((events as ListEventoModel).events);
      else
        yield EventoLoadFailed(error: (events as APIError));
    }

    if (event is EventoRefresh){
      yield EventoLoading();
      yield EventoLoaded(event.events);
    }

/*
    if (event is EventFilter) {
      yield EventoLoading();
      try{
        final mapEntities = await MapRepository.fetchEntities(
          // municipioName
          'alcantir',
          event.filter.value
        );
        if (mapEntities == null){
          final error = _DEF.STRING_FAIL_ENTITIES;
          yield EventoLoadFailed(error: error);
        }else yield EventoLoaded(
          mapEntities,
          event.filter
        );
      }catch (e){
        print(e);
        debugPrintStack();
        yield EventoLoadFailed(error: e.toString());
      }
    }
*/
  }
}