import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

const host = 'api.frankfurter.app';
/*
Obs: Como estamos lidando com promessas, devemos utiliziar o tipo Future para para que o Flutter entenda
que a função retorna uma promessa, logo, a promessa precisa ser resolvida para que o cliente receba as
informações da requisição.

getConverter - Minha estratégia aqui foi pegar  os respectivos parâmetros e realizar  a busca.
Para isso utilizei a biblioteca 'http' para realizar a requisição de GET para a API e então puxar os dados
selecionados em questão. Precisamos converter em uma URL para não dar erros, já que o dart é fortemente tipado.
Como eu já mexo com desenvolvimento web sei que toda requisição tem sua resposta e seu status code, logo
tratando o sucesso retornamos ao usuário o valor de resposta, caso seja outras respostas, será retornado
vazio.

getAllPaises - Os Dropdowns foram criados para receber uma lista de países, para isso realizei um GET da mesma
forma que na função anterior e então puxei todas as informações sobre o nome das moedas e os respectivos países
que as usam.

Eu utilizei nessas requisições tipagem direta sem criar modelos, mesmo sabendo que deveria criar,  no entanto,
como os objetos em que trabalhamos não são tão complexos (digo, as informações que iriamos utilizar), eram tipos
simples, então acabei optando por fazer-os diretamente.

A pasta composable eu a criei pensando muito na estrutura web, mas não sei se é convencional do flutter separar
a parte de consumo de api dessa forma.
 */

Future<num> getConverter(String pais, String pais2, num valor) async {
  final response = await http.get(Uri.parse("https://${host}/latest?amount=" +
      valor.toString() +
      "&from=" +
      pais +
      "&to=" +
      pais2));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    //Como eu já sei o que vem nessa requisição seleciono apenas o que vem dentro desse objeto.
    //Achei mais fácil assim do que ter que lidar com estilo json Map;
    return data["rates"][pais2];
  } else {
    return 0 as num;
  }
}

Future<List<String>> getAllPaises() async {
  final response = await http.get(Uri.parse("https://${host}/currencies"));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<String> listaPaises = [];
    //Do mesmo modo quis ser objetivo aqui, selecionando apenas o que queria da api, logo fiz um map para
    //pegar o valor das chaves que era do meu interesse.
    final analise = Map.from(data);
    analise.forEach((key, value) {
      listaPaises.add(key);
    });
    return listaPaises;
  } else {
    return [];
  }
}
