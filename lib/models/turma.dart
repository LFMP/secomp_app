// Models
import 'package:pet_app/models/api_response.dart';

class TurmaModel {
  int quantidadeMaxInscritos;
  int quantidadeAtualInscritos;
  String nome;
  bool limited;
  int atividadeId;

  TurmaModel({
    this.quantidadeMaxInscritos,
    this.quantidadeAtualInscritos,
    this.nome,
    this.limited,
    this.atividadeId,
  });

  String get description => 'Inscritos: $quantidadeAtualInscritos/$quantidadeMaxInscritos';

  factory TurmaModel.fromJson(Map<String, dynamic> json) => TurmaModel(
    quantidadeMaxInscritos: json["quantidadeMaxInscritos"] == null ? null :
      json["quantidadeMaxInscritos"],
    quantidadeAtualInscritos: json["quantidadeAtualInscritos"] == null ?
      null : json["quantidadeAtualInscritos"],
    nome: json["nome"] == null ? null : json["nome"],
    limited: json["limited"] == null ? null : json["limited"],
    atividadeId: json["atividadeId"] == null ? null : json["atividadeId"],
  );

  Map<String, dynamic> toJson() => {
    "quantidadeMaxInscritos": quantidadeMaxInscritos == null ? null :
      quantidadeMaxInscritos,
    "quantidadeAtualInscritos": quantidadeAtualInscritos == null ? null :
      quantidadeAtualInscritos,
    "nome": nome == null ? null : nome,
    "limited": limited == null ? null : limited,
    "atividadeId": atividadeId == null ? null : atividadeId,
  };

  static List<TurmaModel> fromJsonList(List jsonList) =>
    jsonList == null ? [] : jsonList.map(
    (turmaJson) => TurmaModel.fromJson(turmaJson)).toList();
}

class ListTurmaModel extends APIResponse{
  List<TurmaModel> turmas;

  ListTurmaModel({
  statusCode,
  this.turmas
  }) : super(statusCode: statusCode);

  factory ListTurmaModel.fromJson(List jsonList) => ListTurmaModel(
    turmas: TurmaModel.fromJsonList(jsonList)
  );
}