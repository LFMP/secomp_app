import 'package:equatable/equatable.dart';
// Models
import 'package:pet_app/models/atividade.dart';
import 'package:pet_app/models/turma.dart';

abstract class TurmaEvent extends Equatable {
  TurmaEvent([List props = const []]) : super(props);
}

class TurmaLoad extends TurmaEvent {
  final AtividadeModel atividade;
  TurmaLoad({this.atividade}) : super([atividade]);
  
  @override
  String toString() => 'TurmaLoad';
}

class TurmaRefresh extends TurmaEvent{
  final List<TurmaModel> turmas;
  final AtividadeModel atividade;

  TurmaRefresh(
    this.turmas,
    this.atividade
  ) : super([turmas, atividade]);
  
  @override
  String toString() => 'TurmaRefresh';
}