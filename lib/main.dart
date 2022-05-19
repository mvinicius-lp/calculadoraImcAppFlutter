import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculadora de IMC",
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _pesoController = TextEditingController();
  TextEditingController _alturaController = TextEditingController();

  String _infoText = "informe seus dados";

  void _calcular() {
    double peso = double.parse(_pesoController.text.replaceAll(',', '.'));
    double altura = double.parse(_alturaController.text.replaceAll(',', '.'));
    double imc = peso / (altura * altura);
    _verificarImc(imc);
  }

  void _verificarImc(double imc) {
    setState(() {
      if (imc < 18.6) {
        _infoText = "Abaixo do peso: (${imc.toStringAsPrecision(4)}).";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal: (${imc.toStringAsPrecision(4)}).";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso: (${imc.toStringAsPrecision(4)}).";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obsidade grau I: (${imc.toStringAsPrecision(4)}).";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obsidade grau II: (${imc.toStringAsPrecision(4)}).";
      } else {
        _infoText = "Obsidade grau III: (${imc.toStringAsPrecision(4)}).";
      }
    });
  }

  void _limparCampos() {
    _pesoController.text = "";
    _alturaController.text = "";
    setState(() {
      _infoText = "informe seus dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.fitness_center,
                size: 120.0,
                color: Colors.grey,
              ),
              TextField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
              TextField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => _calcular(),
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
