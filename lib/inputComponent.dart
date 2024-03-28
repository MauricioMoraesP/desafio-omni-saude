import 'package:flutter/material.dart';
/*
Widget utilizando o textField
 */

class inputComponent extends StatelessWidget {
  final inputController;
  final Function(String newValue) changeInput;
  const inputComponent({this.inputController, required this.changeInput});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        child: TextField(
          //Variável para controlar o valor do input, importante para toda regra de negócio da minha aplicação
          controller: inputController,
          //Coloquei o teclado para receber apenas números
          keyboardType: TextInputType.number,
          //E a função para realizar alteração do valor de uma variável que está sendo observada caso seja alterada
          onChanged: (value) => (changeInput(value)),
        ));
  }
}
