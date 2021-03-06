import 'package:bloc_patern_crud/app/screen/sprint/sprint_bloc.dart';
import 'package:bloc_patern_crud/app/screen/sprint/sprint_module.dart';
import 'package:bloc_patern_crud/app/shared/models/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:bloc_patern_crud/app/shared/models/utils/constants.dart';

class SprintWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flip's apps",
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: SprintWidgetState(),
    );
  }
}

class SprintWidgetState extends StatefulWidget {
  const SprintWidgetState({Key? key}) : super(key: key);

  @override
  _SprintWidgetState createState() => _SprintWidgetState();
}

class _SprintWidgetState extends State<SprintWidgetState> {

  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();
  final _textFieldNomeController = TextEditingController();
  final _textFieldURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _bloc.doGetAll();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sprint'),
        actions: <Widget> [
          IconButton(
            onPressed: () {
              _redirecToAdd();
            }, // TODO - Direcionar para pagina de cadastro
            icon: Icon(Icons.add),
        ),
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.sprints,
        builder: (context, AsyncSnapshot<List<SprintGetModel>> snapshot) {
          if(snapshot.hasData){
            final sprints = snapshot.data!;
            return ListView.separated(
              itemBuilder: (_, index){
                final sprint = sprints[index];
                final _client = Client();
                return ListTile(
                  // title: _sprintTitle(sprint),
                  title: Text(sprint.nome),
                  // subtitle: SprintBodyWidget(sprint),
                  subtitle: Text(sprint.link),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    color: Colors.red,
                    onPressed: () async {
                      // TODO - MElhorar Delete - passando para api, dando o loading e atualizando a lista
                      print('clicou');
                      print(Uri.parse('${Constants.API_BASE_URL}/sprint/${sprint.id}'));
                      await _client.delete(Uri.parse('${Constants.API_BASE_URL}/sprint/${sprint.id}'));
                    },
                  ),
                  onTap: () {
                    _showOne(sprint.id);
                  },
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

  void _showOne(id) {

    _bloc.doGetOne(id);

    Navigator.of(context).push( // TODO - verificar pq n??o ta certo o context
        MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Sprint'),
                ),
                body: StreamBuilder(
                  stream: _bloc.sprint,
                  builder: (context, AsyncSnapshot<SprintGetModel> snapshot) {
                    if(snapshot.hasData){
                      final sprint = snapshot.data!;
                      return  ListTile(
                        // title: _sprintTitle(sprint),
                        title: Text(sprint.nome),
                        // subtitle: SprintBodyWidget(sprint),
                        subtitle: Text(sprint.link),
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
        )
    );
  }

  void _redirecToAdd(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('Cadastre uma Sprint'),
                ),
              body: SafeArea(
                child: Container(
                    child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Digite o nome da sprint',
                            ),
                            keyboardType: TextInputType.text,
                            controller: _textFieldNomeController,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Digite a url',
                            ),
                            keyboardType: TextInputType.text,
                            controller: _textFieldURLController,
                          ),
                          ElevatedButton(
                            style:  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () {},
                            child: const Text('Salvar'),
                          ),
                        ]
                    )
                ),
            ),
            );
          }
        )
    );
  }
}