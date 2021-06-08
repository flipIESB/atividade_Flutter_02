import 'package:bloc_patern_crud/app_bloc.dart';
import 'package:bloc_patern_crud/app_widget.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

class AppModule extends ModuleWidget {


  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];

  @override
  Widget get view => AppWidget();

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => RetryClient(Client())),
  ];

  static Inject get to => Inject<AppModule>.of();
}