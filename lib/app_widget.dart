import 'package:bloc_patern_crud/app/screen/sprint/sprint_module.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SprintModule(),
    );
  }
}