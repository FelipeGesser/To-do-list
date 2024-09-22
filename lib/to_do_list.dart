import 'package:flutter/material.dart';

void main() {
  runApp(AppToDoList());
}

class AppToDoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaToDoList(),
    );
  }
}

class TelaToDoList extends StatefulWidget {
  @override
  _TelaToDoListState createState() => _TelaToDoListState();
}

class _TelaToDoListState extends State<TelaToDoList> {
  List<Map<String, dynamic>> _tarefas = [];

  TextEditingController _controlador = TextEditingController();

  void _adicionarTarefa(String tarefa) {
    if (tarefa.isNotEmpty) {
      setState(() {
        _tarefas.add({"tarefa": tarefa, "concluída": false});
      });
      _controlador.clear();
    }
  }

  void _removerTarefa(int indice) {
    setState(() {
      _tarefas.removeAt(indice);
    });
  }

  void _checkTarefa(int indice) {
    setState(() {
      _tarefas[indice]['concluída'] = !_tarefas[indice]['concluída'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controlador,
              decoration: InputDecoration(
                labelText: 'Adicionar tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_controlador.text.isNotEmpty) {
                      _adicionarTarefa(_controlador.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Insira uma tarefa válida.'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, indice) {
                String tarefa = _tarefas[indice]['tarefa']; 
                bool concluida = _tarefas[indice]['concluída'] ?? false;
                return ListTile(
                  title: Text(
                    tarefa,
                    style: TextStyle(
                      decoration: concluida
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removerTarefa(indice),
                  ),
                  leading: Checkbox(
                    value: concluida,
                    onChanged: (valor) => _checkTarefa(indice),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}