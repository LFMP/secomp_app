import 'package:flutter/foundation.dart';
// Exports
export 'package:pet_app/blocs/events/turma.dart';
export 'package:pet_app/blocs/states/turma.dart';
// Bloc
import 'package:bloc/bloc.dart';
import 'package:pet_app/blocs/auth.dart';
import 'package:pet_app/blocs/events/turma.dart';
import 'package:pet_app/blocs/inscricao.dart';
import 'package:pet_app/blocs/states/turma.dart';
import 'package:pet_app/models/atividade.dart';
// Repository
import 'package:pet_app/repositories/turma_repository.dart';
// Models
import 'package:pet_app/models/turma.dart';
import 'package:pet_app/models/api_response.dart';

class TurmaBloc extends Bloc<TurmaEvent, TurmaState>{

  final AuthBloc authBloc;
  final InscricaoBloc inscricaoBloc;

  TurmaBloc({
    @required this.authBloc,
    @required this.inscricaoBloc
  });

  @override
  TurmaState get initialState => TurmaEmpty();

  List<TurmaModel> get currentTurmas => currentState.turmas;
  AtividadeModel get currentAtividade => currentState.atividade;

  
  @override
  Stream<TurmaState> mapEventToState(TurmaEvent event) async* {

    if (event is TurmaLoad) {
      final _currentAtividade =  event.atividade;
      yield TurmaLoading(_currentAtividade);
      
      final turmas = await TurmaRepository.fetchEvents(
        _currentAtividade.id,
        authBloc.token
      );
      
      if (turmas.isSucessfull)
        yield TurmaLoaded(
          (turmas as ListTurmaModel).turmas,
          _currentAtividade
        );
      else
        yield TurmaLoadFailed(
          _currentAtividade,
          error: (turmas as APIError)
        );
    }

    if (event is TurmaRefresh){
      yield TurmaLoading(event.atividade);
      yield TurmaLoaded(event.turmas, event.atividade);
    }

     if (event is TurmaApply){
      inscricaoBloc.dispatch(InscricaoLoad(
        turma: event.chosenTurma,
        atividade: currentAtividade
      ));
      yield TurmaLoaded(
        currentTurmas,
        currentAtividade
      );
    }
  }
}