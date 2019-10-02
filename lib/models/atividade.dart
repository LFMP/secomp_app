import 'package:pet_app/models/api_response.dart';

class AtividadeModel {
  String nome;
  DateTime anoAtividade;
  int limiteInscritos;
  String descricao;
  String preRequisitos;
  int valor;
  int cargaHoraria;
  int id;
  int eventoId;
  int categoriaId;

  AtividadeModel({
    this.nome,
    this.anoAtividade,
    this.limiteInscritos,
    this.descricao,
    this.preRequisitos,
    this.valor,
    this.cargaHoraria,
    this.id,
    this.eventoId,
    this.categoriaId,
  });

  // String get description => ''

  factory AtividadeModel.fromJson(Map<String, dynamic> json) => AtividadeModel(
    nome: json["nome"] == null ? null : json["nome"],
    anoAtividade: json["anoAtividade"] == null ? null : DateTime.parse(
      json["anoAtividade"]),
    limiteInscritos: json["limiteInscritos"] == null ? null :
      json["limiteInscritos"],
    descricao: json["descricao"] == null ? null : json["descricao"],
    preRequisitos: json["preRequisitos"] == null ? null : json["preRequisitos"],
    valor: json["valor"] == null ? null : json["valor"],
    cargaHoraria: json["cargaHoraria"] == null ? null : json["cargaHoraria"],
    id: json["id"] == null ? null : json["id"],
    eventoId: json["eventoId"] == null ? null : json["eventoId"],
    categoriaId: json["categoriaId"] == null ? null : json["categoriaId"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome == null ? null : nome,
    "anoAtividade": anoAtividade == null ? null :
      anoAtividade.toIso8601String(),
    "limiteInscritos": limiteInscritos == null ? null : limiteInscritos,
    "descricao": descricao == null ? null : descricao,
    "preRequisitos": preRequisitos == null ? null : preRequisitos,
    "valor": valor == null ? null : valor,
    "cargaHoraria": cargaHoraria == null ? null : cargaHoraria,
    "id": id == null ? null : id,
    "eventoId": eventoId == null ? null : eventoId,
    "categoriaId": categoriaId == null ? null : categoriaId,
  };

  static List<AtividadeModel> fromJsonList(List jsonList) =>
  jsonList == null ? [] : jsonList.map(
    (atividadeJson) => AtividadeModel.fromJson(atividadeJson)).toList();
}

class ListAtividadeModel extends APIResponse{
  List<AtividadeModel> atividades;

  ListAtividadeModel({
    statusCode,
    this.atividades
  }) : super(statusCode: statusCode);

  factory ListAtividadeModel.fromJson(List jsonList) => ListAtividadeModel(
    atividades: AtividadeModel.fromJsonList(jsonList)
  );
}