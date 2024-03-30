OBS: Eu tive a ideia de que qualquer um dos inputs que escolher para preencher os valores fossem realizado a conversão, ou seja, vc escolhe o sentido que quer, além disso, desejei atribuir valores padrões no inicio da aplicação.

1-Confesso que um dos meus maiores desafios neste projeto foi lidar com o erro "[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: type 'int' is not a subtype of type 'FutureOr<double>'". Para resolver isso, pesquisei na documentação sobre tipos para entender por que não estava obtendo sucesso com meu retorno. Funcionava, porém, havia uma limitação: quando excedia a quantidade de números que deveria inserir, não conseguia mais converter o valor. Então, substituí pelos tipos primitivos que Dart disponibiliza. Optei por usar o tipo num, pois até então não apresentou falhas como o double estava apresentando. Depois de pesquisar, descobri que ele pode falhar por não ter tanta precisão.

2-Um segundo desafio foi entender como entregar uma aplicação de conversão, o que ela deveria ter e o que deveria fornecer visualmente. Para isso, examinei alguns sites exemplos para entender melhor como eles lidavam com esse tipo de recurso e funcionalidades.

3-Outro desafio que encontrei foi garantir que os parâmetros não fossem nulos. Como venho do TypeScript e ele utiliza alguns sinais diferentes para isso, às vezes tive que parar e gastar um pouco de tempo para entender o que estava acontecendo com meu código.





