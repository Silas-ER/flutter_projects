import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorPage(title: 'Calculadora IMC'),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  String? _resultado;

  void calculoIMC() {
    final double altura = double.tryParse(_alturaController.text) ?? 0;
    final double peso = double.tryParse(_pesoController.text) ?? 0;
    final double imc = peso / (altura * altura);

    if (imc > 0 && imc < 18.5) {
      _resultado = 'assets/images/baixoPeso.png';
    } else if (imc < 25) {
      _resultado = 'assets/images/pesoIdeal.png';
    } else if (imc < 30) {
      _resultado = 'assets/images/sobrepeso.png';
    } else if (imc < 35) {
      _resultado = 'assets/images/obeso.png';
    } else if (imc < 40) {
      _resultado = "assets/images/severa.png";
    } else if (imc > 40) {
      _resultado = "assets/images/morbida.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Informe sua altura e peso para calcular o IMC:',
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _alturaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Altura (m)',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _pesoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Peso (kg)',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(calculoIMC);
                },
                child: const Text('Calcular IMC'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              if (_resultado != null) ...[
                const Text(
                  'Resultado:',
                  style: TextStyle(fontSize: 20),
                ),
                Image.asset(_resultado!,
                    width: 100), 
              ],
            ],
          ),
        ),
      )
      ),
    );
  }
}
