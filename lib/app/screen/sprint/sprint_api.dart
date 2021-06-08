import 'dart:convert';
import 'package:bloc_patern_crud/app/shared/models/get.dart';
import 'package:bloc_patern_crud/app/shared/models/utils/constants.dart';
import 'package:bloc_patern_crud/app_module.dart';
import 'package:http/http.dart';

class SprintApi {
  final Client _client;
  SprintApi(this._client);

  Future<List<SprintGetModel>> getAll() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));
    if(response.statusCode >= 200 && response.statusCode < 300 ){
      final List<dynamic> JSprintGetAll = json.decode(response.body);
      final sprints = JSprintGetAll.map((s) => SprintGetModel.fromJson(s)).toList();

      return sprints;
    } else {
      throw Exception('Deu erro ao recuperar sprints');
    }
  }
  
  /*Future<SprintGetModel> getOne(id) async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint/$id'));
    if(response.statusCode >= 200 && response.statusCode < 300 ){
      final  JSprintGetOne = json.decode(response.body); // TODO - Achar o nome do Item
      final sprint = SprintGetModel.fromJson(JSprintGetOne); // TODO - Verificar se é assim mesmo

      return sprint;
    }else {
      throw Exception('Deu ruim ao recpuerar o sprint');
    }
  }

  Future<SprintGetModel> deleteOne(id) async {
    final response = await _client.delete(Uri.parse('${Constants.API_BASE_URL}/sprint/$id')); // TODO - Precisa do respose?
    if(response.statusCode >= 200 && response.statusCode < 300 ){
      // TODO - Oque retornoar?

    }else {
      throw Exception('Deu ruim ao recpuerar o sprint');
    }
  }*/

}
