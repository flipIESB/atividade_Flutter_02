// To parse this JSON data, do
//
//     final sprintGetModel = sprintGetModelFromJson(jsonString);

import 'dart:convert';

class SprintGetModel {
  SprintGetModel({
    required this.id,
    required this.nome,
    required this.link,
  });

  int id;
  String nome;
  String link;

  factory SprintGetModel.fromRawJson(String str) => SprintGetModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SprintGetModel.fromJson(Map<String, dynamic> json) => SprintGetModel(
    id: json["id"],
    nome: json["nome"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "link": link,
  };
}
