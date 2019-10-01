// Exports
export 'package:pet_app/blocs/events/event.dart';
export 'package:pet_app/blocs/states/event.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/events/event.dart';
import 'package:pet_app/blocs/states/event.dart';
import 'package:pet_app/models/api_response.dart';
// Repository
import 'package:pet_app/repositories/event_repository.dart';
// Models
import 'package:pet_app/models/event.dart';

class EventBloc extends Bloc<EventEvent, EventState>{

  final AuthBloc authBloc;

  EventBloc({this.authBloc});

  @override
  EventState get initialState => EventEmpty();

  List<EventModel> get currentEvents => currentState.events;
  
  // MapFilter get currentFilter => currentState.filter;

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {

    if (event is EventLoad) {
      yield EventLoading();
      
      final events = await EventRepository.fetchEvents(authBloc.token);
      
      if (events.isSucessfull)
        yield EventLoaded((events as ListEventModel).events);
      else
        yield EventLoadFailed(error: (events as APIError));
    }

    if (event is EventRefresh){
      yield EventLoading();
      yield EventLoaded(event.events);
    }

/*
    if (event is EventFilter) {
      yield EventLoading();
      try{
        final mapEntities = await MapRepository.fetchEntities(
          // municipioName
          'alcantir',
          event.filter.value
        );
        if (mapEntities == null){
          final error = _DEF.STRING_FAIL_ENTITIES;
          yield EventLoadFailed(error: error);
        }else yield EventLoaded(
          mapEntities,
          event.filter
        );
      }catch (e){
        print(e);
        debugPrintStack();
        yield EventLoadFailed(error: e.toString());
      }
    }
*/
  }
}