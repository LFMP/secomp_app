// Exports
export 'package:pet_app/blocs/events/atividade.dart';
export 'package:pet_app/blocs/states/atividade.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/events/atividade.dart';
import 'package:pet_app/blocs/states/atividade.dart';
import 'package:pet_app/models/api_response.dart';
import 'package:pet_app/models/evento.dart';
// Repository
import 'package:pet_app/repositories/atividade_repository.dart';
// Models
import 'package:pet_app/models/atividade.dart';

class AtividadeBloc extends Bloc<AtividadeEvent, AtividadeState>{

  final AuthBloc authBloc;

  AtividadeBloc({this.authBloc});

  @override
  AtividadeState get initialState => AtividadeEmpty();

  List<AtividadeModel> get currentAtividades => currentState.atividades;
  EventoModel get currentEvento => currentState.evento;

  
  @override
  Stream<AtividadeState> mapEventToState(AtividadeEvent event) async* {

    if (event is AtividadeLoad) {
      final _currentEvent =  event.evento;
      yield AtividadeLoading(_currentEvent);
      
      final atividades = await AtividadeRepository.fetchEvents(
        _currentEvent.id,
        authBloc.token
      );
      
      if (atividades.isSucessfull)
        yield AtividadeLoaded(
          (atividades as ListAtividadeModel).atividades,
          _currentEvent
        );
      else
        yield AtividadeLoadFailed(
          _currentEvent,
          error: (atividades as APIError)
        );
    }

    if (event is AtividadeRefresh){
      yield AtividadeLoading(event.evento);
      yield AtividadeLoaded(event.atividades, event.evento);
    }
  }
}