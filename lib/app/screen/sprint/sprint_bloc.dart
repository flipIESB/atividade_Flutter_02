import 'package:bloc_patern_crud/app/screen/sprint/sprint_api.dart';
import 'package:bloc_patern_crud/app/shared/models/get.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class SprintBloc extends BlocBase {

  final SprintApi _api;
  SprintBloc(this._api);

  late final _loading = BehaviorSubject<bool>();
  late final _getAllSprints = PublishSubject<List<SprintGetModel>>();
  late final _getOneSprint = PublishSubject<SprintGetModel>();
  // late final _deleleOneSprint =

  Stream<bool> get loading => _loading.stream;
  Stream<List<SprintGetModel>> get sprints => _getAllSprints.stream;
  Stream<SprintGetModel> get sprint => _getOneSprint.stream;

  doGetAll() async {
    _loading.sink.add(true);

    final sprints = await _api.getAll();
    _getAllSprints.sink.add(sprints);

    _loading.sink.add(false);
  }

  doGetOne(id) async {
    _loading.sink.add(true);

    final sprint = await _api.getOne(id);
    _getOneSprint.sink.add(sprint);

    _loading.sink.add(false);
  }

  @override
  void dispose() {
    _loading.close();
    _getAllSprints.close();
    _getOneSprint.close();
  }
}