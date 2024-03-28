import 'package:flutter/material.dart';
/*
Aqui é um widget que criei para encapsular todo componente e montá-lo conforme a estrutura que eu queria.
 */

class dropDownsComponent extends StatelessWidget {
  final String pais;
  final List<String> moedas;
  final Function(String valor) functionDrodpwons;
  //Construtor do widget
  const dropDownsComponent(this.pais, this.moedas, this.functionDrodpwons);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        //Coloquei uma variável para receber e associar o valor ao dropdown
        value: pais,
        //Aqui realizei um map na lista e para cada um associei um valor e um componente a ser renderizado.
        items: moedas.map((String dropDownString) {
          return DropdownMenuItem<String>(
            value: dropDownString,
            child: Text(dropDownString),
          );
          /*Como é uma lista de itens, precisamos converter/reforçar o resultado para uma lista e evitar 
          erros de tipagem*/
        }).toList(),
        /*Função associada a alguma ação dentro do dropdown, que no caso seria escolher a moeda de um determinado
        pais*/
        onChanged: (newValue) => functionDrodpwons(newValue!));
  }
}
