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
      final List<dynamic> JSprintGetModel = json.decode(response.body);
      final sprints = JSprintGetModel.map((s) => SprintGetModel.fromJson(s)).toList();

      return sprints;
    } else {
      throw Exception('Deu erro ao recuperar sprints');
    }
  }

}
