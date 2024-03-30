import 'package:flutter/material.dart';
import '../models/tarefa.dart';
import 'package:intl/intl.dart';


class FormTarefa extends StatefulWidget {
  final Function(String, String, DateTime, DateTime, String, String) onSubmit;

  FormTarefa(this.onSubmit);

  @override
  _FormTarefaState createState() => _FormTarefaState();
}

//Formulario para adicionar tarefas
class _FormTarefaState extends State<FormTarefa> {
  final _tarefaController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _observacaoController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();
  Prioridade _prioridadeSelecionada = Prioridade.baixa;

  //Função para submeter o formulário
  void _submitForm() {
    if (_tarefaController.text.isEmpty) {
      return;
    }

    widget.onSubmit(
      _tarefaController.text,
      _descricaoController.text,
      _dataSelecionada,
      DateTime.now(),
      _prioridadeSelecionada.toString().split('.').last,
      _observacaoController.text,
    );
  }

  //Funcao para mostrar o seletor de data
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dataSelecionada = pickedDate;
      });
    });
  }

  //Construção da interface do formulário
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: 'Título da Tarefa'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_dataSelecionada == null
                    ? 'Nenhuma data selecionada!'
                    : 'Data: ${DateFormat('dd/MM/yyyy').format(_dataSelecionada)}'),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text('Selecionar Data'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Prioridade: '),
              ],
            ),
            DropdownButton<Prioridade>(
              value: _prioridadeSelecionada,
              onChanged: (Prioridade? newValue) {
                setState(() {
                  _prioridadeSelecionada = newValue!;
                });
              },
              items: Prioridade.values.map((Prioridade classType) {
                return DropdownMenuItem<Prioridade>(
                  value: classType,
                  child: Text(classType.toString().split('.').last),
                );
              }).toList(),
            ),
            TextField(
              controller: _observacaoController,
              decoration: InputDecoration(labelText: 'Observações'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Adicionar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}

