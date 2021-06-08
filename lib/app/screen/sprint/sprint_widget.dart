import 'package:bloc_patern_crud/app/screen/sprint/sprint_bloc.dart';
import 'package:bloc_patern_crud/app/screen/sprint/sprint_module.dart';
import 'package:bloc_patern_crud/app/shared/models/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SprintWidget extends StatelessWidget {

  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  @override
  Widget build(BuildContext context) {

    _bloc.doGetAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint')
      ),
      body: StreamBuilder(
        stream: _bloc.sprints,
        builder: (context, AsyncSnapshot<List<SprintGetModel>> snapshot) {
          if(snapshot.hasData){
            final sprints = snapshot.data!;
            return ListView.separated(
                itemBuilder: (_, index){
                  final sprint = sprints[index];
                  return ListTile(
                    // title: _sprintTitle(sprint),
                    title: Text(sprint.nome),
                    // subtitle: SprintBodyWidget(sprint),
                    subtitle: Text(sprint.link),
                  );
                },
                separatorBuilder: (_, __) => Divider(),
                itemCount: sprints.length,
            );
          }
          return StreamBuilder(
            stream: _bloc.loading,
            builder: (_, AsyncSnapshot<bool> snapshot){
              final loading = snapshot.data ?? false;
              if(loading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}