import 'dart:math';
import 'package:flutter/material.dart';
import 'models/tarefa.dart';
import 'components/lista_tarefa.dart';
import 'components/form_tarefa.dart';

//Execução do app
void main() => runApp(ToDoListApp());

//Definições do app
class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.purple,
              secondary: Colors.amber,
            ),
      ),
    );
  }
}

//Página principal do app
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//criação de tarefas
class _MyHomePageState extends State<MyHomePage> {
  final List<Tarefa> _tarefas = [
    Tarefa(
      id: '1',
      titulo: 'Comprar pão',
      descricao: 'Comprar pão na padaria',
      data: DateTime.now().add(Duration(days: 1)),
      dataCriacao: DateTime.now(),
      prioridade: Prioridade.baixa,
      observacao: 'Pão francês',
    ),
    Tarefa(
      id: '2',
      titulo: 'Comprar leite',
      descricao: 'Comprar leite no mercado',
      data: DateTime.now().add(Duration(days: 2)),
      dataCriacao: DateTime.now(),
      prioridade: Prioridade.media,
      observacao: 'Leite desnatado',
    ),
    Tarefa(
      id: '3',
      titulo: 'Comprar carne',
      descricao: 'Comprar carne no açougue',
      data: DateTime.now().add(Duration(days: 3)),
      dataCriacao: DateTime.now(),
      prioridade: Prioridade.alta,
      observacao: 'Carne de primeira',
    ),
  ]; //Tarefas pré cadastradas

  //Método para adicionar tarefas
  void _novaTarefa(String titulo, String descricao, DateTime dataSelecionada,
      DateTime dataCriacao, String prioridade, String observacao) {
    final novaTarefa = Tarefa(
      id: Random().nextInt(9999).toString(),
      titulo: titulo,
      descricao: descricao,
      data: dataSelecionada,
      dataCriacao: dataCriacao,
      prioridade: Prioridade.values.firstWhere((e) =>
      e
          .toString()
          .split('.')
          .last
          .toLowerCase() ==
          prioridade.toLowerCase()),
      observacao: observacao,
    );
    setState(() {
      _tarefas.add(novaTarefa);
    });
    Navigator.of(context).pop(); // Fecha a modal
  }

  //editar tarefas
  void _atualizarTarefa(Tarefa tarefaAtualizada) {
    setState(() {
      final index =
      _tarefas.indexWhere((tarefa) => tarefa.id == tarefaAtualizada.id);
      if (index >= 0) {
        _tarefas[index] = tarefaAtualizada;
      }
    });
  }

  //remoção de tarefas no setstate
  void _removeTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  //ordenar por data de criacao
  void _ordenarPorDataCriacao() {
    setState(() {
      _tarefas.sort((a, b) => a.dataCriacao.compareTo(b.dataCriacao));
    });
  }

  //ordenar por prioridade
  void _ordenarPorPrioridade() {
    setState(() {
      _tarefas.sort((a, b) => b.prioridade.index.compareTo(a.prioridade.index));
    });
  }

  //ordenar por data
  void _ordenarPorData() {
    setState(() {
      _tarefas.sort((a, b) => a.data.compareTo(b.data));
    });
  }

  //abertura do modal
  void _openTaskFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return FormTarefa(_novaTarefa);
      },
    );
  }

  //build geral do app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Altura ajustada para 70
        child: AppBar(
          backgroundColor: Colors.grey,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('TO DO LIST', style: TextStyle(fontSize: 22),),
                     // Ajuste na apresentação do texto
                  ),
                  IconButton( // Movido para fora do Row anterior para alinhamento correto
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Ordenar por:"),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _ordenarPorDataCriacao();
                                    },
                                    child: Text("Data de Criação"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _ordenarPorPrioridade();
                                    },
                                    child: Text("Prioridade"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _ordenarPorData();
                                    },
                                    child: Text("Data"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
                child: ListaTarefa(_tarefas, _removeTarefa, _atualizarTarefa)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTaskFormModal(context),
      ),
    );
  }
}