import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/tarefa.dart'; // Ajuste o caminho conforme necessário

class DetalhesTarefaScreen extends StatefulWidget {
  final Tarefa tarefa;
  final VoidCallback onDelete; // Callback para exclusão
  final Function(Tarefa) atualizarTarefa; // Callback para atualização

  DetalhesTarefaScreen({
    required this.tarefa,
    required this.onDelete,
    required this.atualizarTarefa,
  });

  @override
  _DetalhesTarefaScreenState createState() => _DetalhesTarefaScreenState();
}

// Interface da tela de detalhes da tarefa
class _DetalhesTarefaScreenState extends State<DetalhesTarefaScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _descricaoController;
  late TextEditingController _dataController;
  late TextEditingController _prioridadeController;
  late TextEditingController _observacaoController;

  // Inicialização dos controladores
  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tarefa.titulo);
    _descricaoController = TextEditingController(text: widget.tarefa.descricao);
    _dataController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.tarefa.data));
    _prioridadeController = TextEditingController(text: widget.tarefa.prioridade.toString().split('.').last);
    _observacaoController = TextEditingController(text: widget.tarefa.observacao);
  }

  // Descarte dos controladores
  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataController.dispose();
    _prioridadeController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  // Construção da interface da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa.titulo), // Título da tarefa
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Editar Tarefa"),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: _tituloController,
                            decoration: InputDecoration(labelText: 'Título'),
                          ),
                          TextField(
                            controller: _descricaoController,
                            decoration: InputDecoration(labelText: 'Descrição'),
                          ),
                          TextField(
                            controller: _dataController,
                            decoration: InputDecoration(labelText: 'Data de Execução'),
                          ),
                          TextField(
                            controller: _prioridadeController,
                            decoration: InputDecoration(labelText: 'Prioridade'),
                          ),
                          TextField(
                            controller: _observacaoController,
                            decoration: InputDecoration(labelText: 'Observação'),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          Tarefa tarefaAtualizada = Tarefa(
                            id: widget.tarefa.id,
                            titulo: _tituloController.text,
                            descricao: _descricaoController.text,
                            data: DateFormat('dd/MM/yyyy').parse(_dataController.text),
                            dataCriacao: widget.tarefa.dataCriacao,
                            prioridade: Prioridade.values.firstWhere(
                                  (e) => e.toString().split('.').last.toLowerCase() == _prioridadeController.text.toLowerCase(),
                              orElse: () => widget.tarefa.prioridade,
                            ),
                            observacao: _observacaoController.text,
                          );

                          setState(() {
                            widget.tarefa.titulo = tarefaAtualizada.titulo;
                            widget.tarefa.descricao = tarefaAtualizada.descricao;
                            widget.tarefa.data = tarefaAtualizada.data;
                            widget.tarefa.prioridade = tarefaAtualizada.prioridade;
                            widget.tarefa.observacao = tarefaAtualizada.observacao;
                          });
                          widget.atualizarTarefa(tarefaAtualizada);
                          Navigator.of(context).pop(tarefaAtualizada);
                        },
                        child: Text("Salvar"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Excluir Tarefa"),
                    content: Text("Deseja realmente excluir a tarefa ${widget.tarefa.titulo}?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.onDelete();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Descrição: ${widget.tarefa.descricao}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Data de Execução: ${DateFormat('dd/MM/yyyy').format(widget.tarefa.data)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Data de Criação: ${DateFormat('dd/MM/yyyy').format(widget.tarefa.dataCriacao)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Prioridade: ${widget.tarefa.prioridade.toString().split('.').last}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
