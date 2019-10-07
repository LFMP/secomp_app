import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
// Models
import 'package:pet_app/models/inscricao.dart';
import 'package:pet_app/models/presenca.dart';
import 'package:pet_app/models/api_response.dart';

abstract class PresencaState extends Equatable {
  final PresencaModel presenca;
  final InscricaoModel inscricao;

  PresencaState(
    this.presenca,
    this.inscricao,
    [List props = const []]
  ) : super([presenca, inscricao]..addAll(props));
}

class PresencaEmpty extends PresencaState {
  PresencaEmpty() : super(null, null);

  @override
  String toString() => 'PresencaEmpty';
}

class PresencaLoading extends PresencaState {
  PresencaLoading(
    InscricaoModel inscricao
  ) : super(null, inscricao);

  @override
  String toString() => 'PresencaLoading';
}

class PresencaSetSucessfull extends PresencaState {
  final PresencaModel presenca;
  final InscricaoModel inscricao;

  PresencaSetSucessfull(
    @required this.presenca,
    @required this.inscricao
  ) : super(presenca, inscricao);

  @override
  String toString() => 'PresencaSetSucessfull';
}

class PresencaSetFailed extends PresencaState {
  final APIError error;

  PresencaSetFailed(
    PresencaModel presenca,
    InscricaoModel inscricao, {this.error}
  ) : super(presenca, inscricao, [error]);

  @override
  String toString() => 'PresencaSetFailed';
}
