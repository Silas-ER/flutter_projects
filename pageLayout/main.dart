import 'package:flutter/material.dart'; // Importa o material design

void main() { // Função chamada quando o aplicativo é iniciado e inicia o MyApp como raiz de widgets
  runApp(MyApp());
}

class MyApp extends StatelessWidget { // Utilizando o StatelessWidget pois não é necessário manter estados internos durante a execução do app
  const MyApp({Key? key}) : super(key: key); // Utilizado caso necessite passar chaves de modificação de widgets

  @override
  Widget build(BuildContext context) {// Widget de construção do app
    return MaterialApp( //Utilizado para envolver os widgets
      debugShowCheckedModeBanner: false,
      home: Scaffold( //Estrutura básica
        body: Column( //Organizando filhos verticalmente
          children: <Widget>[
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.green)),
                ],
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.blueAccent)),
                  Expanded(child: Container(color: Colors.yellow)),
                ],
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.yellow)),
                  Expanded(child: Container(color: Colors.yellow)),
                ],
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.blueAccent)),
                  Expanded(child: Container(color: Colors.yellow)),
                  Expanded(child: Container(color: Colors.yellow)),
                  Expanded(child: Container(color: Colors.yellow)),
                ],
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.red)),
                  Expanded(child: Container(color: Colors.yellow)),
                ],
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.green)),
                  Expanded(child: Container(color: Colors.blueAccent)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
