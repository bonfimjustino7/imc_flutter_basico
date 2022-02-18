import 'package:flutter/material.dart';

class TelaIncial extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TelaInicialState();
  }
}

class TelaInicialState extends State<TelaIncial> {
  String _textoResultado = "IMC: 74";
  double imc = 0.0;
  final TextEditingController _controllerPeso = TextEditingController();
  final TextEditingController _controllerAltura = TextEditingController();
  String _nameImage = '';
  String mode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
      ),
      body: Column(
        children: <Widget>[
          criarCampoTexto("Peso (kg):", _controllerPeso),
          criarCampoTexto("Altura (cm):", _controllerAltura),
          Text(
            _textoResultado,
            style: const TextStyle(fontSize: 25.0),
          ),
          SizedBox(
            height: 50.0,
            width: 200.0,
            child: ElevatedButton(
              onPressed: () {
                double peso = double.parse(_controllerPeso.text);
                double altura = double.parse(_controllerAltura.text);

                debugPrint('Peso: $peso');
                debugPrint('Altura: $altura');

                if (altura != null) {
                  double _imc = (peso / (altura * altura));
                  setState(() {
                    _textoResultado = 'IMC: $_imc';
                    imc = _imc;
                  });
                } else {
                  setState(() {
                    _textoResultado = 'Preencha os campos para IMC';
                  });
                }
              },
              child: const Text("Calcular IMC"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: imagemImc(),
          )
        ],
      ),
    );
  }

  Column imagemImc() {
    if (imc < 18.5) {
      setState(() {
        _nameImage = 'magro.jpg';
        mode = 'Abaixo do Peso';
      });
    } else if (imc >= 18.5 && imc <= 24.9) {
      setState(() {
        _nameImage = 'normal.jpg';
        mode = 'Peso Normal';
      });
    } else if (imc >= 25 && imc <= 29.9) {
      setState(() {
        _nameImage = 'sobrepeso.jpg';
        mode = 'Sobrepeso';
      });
    } else if (imc >= 30 && imc <= 34.9) {
      setState(() {
        _nameImage = 'obesidade1.png';
        mode = 'Obesidade Grau I';
      });
    } else if (imc >= 35 && imc <= 39.9) {
      setState(() {
        _nameImage = 'obesidade2.jpeg';
        mode = 'Obesidade Grau II';
      });
    } else {
      setState(() {
        _nameImage = 'sobrepeso.jpg';
        mode = 'Obesidade Grau III ou Mórbida';
      });
    }

    return Column(
      children: [
        Image.asset('assets/$_nameImage', height: 100),
        Text(mode),
      ],
    );
  }

  TextField criarCampoTexto(String texto, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: texto,
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(fontSize: 12.0, color: Colors.blue)),
    );
  }
}
