//tarefa.dart

enum Prioridade { baixa, media, alta }

class Tarefa {
  String id;
  String titulo;
  String descricao;
  DateTime data;
  DateTime dataCriacao;
  Prioridade prioridade;
  String observacao;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.dataCriacao,
    required this.prioridade,
    required this.observacao,
  });
}
