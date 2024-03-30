import 'package:flutter/material.dart';
import '../models/tarefa.dart'; // Certifique-se de que o caminho está correto
import 'package:intl/intl.dart';
import 'detalhes_tarefa.dart'; // Certifique-se de que o caminho está correto

class ListaTarefa extends StatefulWidget {
  final List<Tarefa> listaTarefas; // Lista de tarefas
  final Function(int) removeTarefa; // Função para remover tarefa
  final Function(Tarefa) atualizarTarefa; // Função para atualizar tarefa

  ListaTarefa(this.listaTarefas, this.removeTarefa, this.atualizarTarefa); // Construtor

  @override
  _ListaTarefaState createState() => _ListaTarefaState();
}

//Interface da lista de tarefas
class _ListaTarefaState extends State<ListaTarefa> {
  Widget build(BuildContext context) {
    return widget.listaTarefas.isEmpty
        ? Center(child: Text("Nenhuma Tarefa Cadastrada"))
        : ListView.builder(
            itemCount: widget.listaTarefas.length,
            itemBuilder: (ctx, index) {
              final tarefa = widget.listaTarefas[index];
              // Obtenção de datas dentro do itemBuilder
              final dataAtual = DateTime.now();
              final dataHoje =
                  DateTime(dataAtual.year, dataAtual.month, dataAtual.day);
              return InkWell(
                onTap: () async{
                  final Tarefa? tarefaAtualizada = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetalhesTarefaScreen(
                        tarefa: tarefa,
                        onDelete:() => widget.removeTarefa(index),
                        atualizarTarefa: widget.atualizarTarefa,
                      ),
                    ),
                  );
                  if(tarefaAtualizada != null){
                    widget.atualizarTarefa(tarefaAtualizada);
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(tarefa.titulo.toUpperCase()),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(tarefa.data),
                            style: TextStyle(
                              color: tarefa.data.isBefore(dataHoje)
                                  ? Colors.red
                                  : (tarefa.data.day == DateTime.now().day &&
                                          tarefa.data.month ==
                                              DateTime.now().month &&
                                          tarefa.data.year ==
                                              DateTime.now().year)
                                      ? Colors.blue
                                      : null,
                            ),
                          ),
                        ),
                        Text(
                          tarefa.prioridade
                              .toString()
                              .split('.')
                              .last
                              .toUpperCase(),
                          style: TextStyle(
                            color: tarefa.prioridade == Prioridade.baixa
                                ? Colors.green
                                : tarefa.prioridade == Prioridade.media
                                    ? Colors.orange
                                    : Colors.red,
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Exibe o AlertDialog para confirmar a exclusão
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Excluir Tarefa"),
                                  content: Text(
                                      "Deseja realmente excluir a tarefa ${tarefa.titulo}?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Fecha o diálogo sem realizar ações
                                      },
                                      child: Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Fecha o diálogo
                                        widget.removeTarefa(
                                            index); // Chama o callback de remoção passado para ListaTarefa
                                      },
                                      child: Text("Excluir"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
