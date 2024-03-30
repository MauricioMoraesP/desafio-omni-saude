import 'package:flutter/material.dart';
/*
Widget utilizando o textField
 */

class InputComponent extends StatelessWidget {
  final inputController;
  final Function(String newValue) changeInput;
  const InputComponent({this.inputController, required this.changeInput});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 50,
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          //Alinhando o texto no meio do textField
          textAlign: TextAlign.center,
          //Personalizando o button
          decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide()),
              labelStyle: TextStyle(fontSize: 14)),
          style: TextStyle(fontWeight: FontWeight.w500),
          //Variável para controlar o valor do input, importante para toda regra de negócio da minha aplicação
          controller: inputController,
          //Coloquei o teclado para receber apenas números
          keyboardType: TextInputType.number,
          //E a função para realizar alteração do valor de uma variável que está sendo observada caso seja alterada
          onChanged: (value) => (changeInput(value)),
        ));
  }
}
