import 'package:bloc_patern_crud/app/screen/sprint/sprint_api.dart';
import 'package:bloc_patern_crud/app/shared/models/get.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class SprintBloc extends BlocBase {

  final SprintApi _api;
  SprintBloc(this._api);

  late final _getAllSprints = PublishSubject<List<SprintGetModel>>();
  late final _loading = BehaviorSubject<bool>();

  Stream<List<SprintGetModel>> get sprints => _getAllSprints.stream;
  Stream<bool> get loading => _loading.stream;

  doGetAll() async {
    _loading.sink.add(true);

    final sprints = await _api.getAll();
    _getAllSprints.sink.add(sprints);

    _loading.sink.add(false);
  }

  doGetOne() async {
    _loading.sink.add(true);

    final sprint = await _api.getOne();


    _loading.sink.add(false);
  }

  @override
  void dispose() {
    _getAllSprints.close();
    _loading.close();
  }
}