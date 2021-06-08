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
  
  Future<SprintGetModel> getOne(id) async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint/$id'));
    print(response);
    if(response.statusCode >= 200 && response.statusCode < 300 ){
      return SprintGetModel.fromJson(json.decode(response.body));
    }else {
      throw Exception('Deu ruim ao recpuerar o sprint');
    }
  }

  void deleteOne(id) async {
    final response = await _client.delete(Uri.parse('${Constants.API_BASE_URL}/sprint/$id')); // TODO - Precisa do respose?
    if(response.statusCode >= 200 && response.statusCode < 300 ){
      // TODO - Oque retornoar?

    }else {
      throw Exception('Deu ruim ao recpuerar o sprint');
    }
  }

 /* void cadastrar(dados) async {
    final response = await _client.post(Uri.parse('${Constants.API_BASE_URL}/sprint')); // TODO - Onde vai o body?
  }*/

}
