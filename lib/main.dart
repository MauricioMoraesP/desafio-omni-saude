import 'package:desafio/buttonChangeComp.dart';
import 'package:desafio/dropdowns.dart';
import 'package:desafio/inputComponent.dart';
import 'package:flutter/material.dart';
import 'composable/functionAsync.dart';

void main() {
  runApp(const MyApp());
}

//Utilizei a inicialização padrão do flutter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Estágio',
      home: const MyHomePage(title: 'HomePage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Variável para controlar o texto exibido dentro dos inputs
  TextEditingController _text1 = TextEditingController();
  TextEditingController _text2 = TextEditingController();
  //Variável que vai receber a lista de nome dos paises;
  List<String> listaPaises = [];
  //Valores padrões para ficar selecionado o primeiro e o segundo dropdown
  String pais1 = 'USD';
  String pais2 = 'EUR';
  //Valores que são atualizados conforme eu faço alterações no meu textField
  num input1 = 0.0;
  num input2 = 0.0;
//Controlador para zerar o texto de um dos inputs
  bool resetInputs = true;
  bool resetInputs2 = true;

//Variável para gerir e evitar realizar fetch sem valores definidos
  bool notError = false;

/*Essa função abstrata é uma sobrescrita que garante que uma determinada declaração seja chamada na rederização
 da árvore de componentes, como os dropDowns têm que ser alimentados então precisa ser chamada logo de inicio
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCountry();
  }

/*
Essa função é para dados assincronos criados no composable e receber os dados dos paises que irão compor o
dropdown. Como a variável valores irá mudar, então precisamos colocar ela dentro de um setState.
 */
  void getAllCountry() async {
    final response = await getAllPaises();
    setState(() {
      listaPaises = response;
    });
  }

/*
Esta função eu utilizei uma abordagem diferente, na qual tratei a função com retorno de uma promise, pois, por
algum motivo que eu não entendi, estava apontando erro por conta do retorno da função importada, aí tive que 
ajustar a função para que retornasse os devidos valores. */
  Future<num> alterarValorInput2(num valor, String pais1, String pais2) async {
    final response = await getConverter(pais1, pais2, valor);
    return response;
  }

/*
Esta função foi criada no intuito de atualizar  de acordo com a conversão input2 e com isso o valor 
do textField2.
 */
  void mudarInput1(newValue) async {
    /*Caso ocorra do meu novo valor ser nada ' ', evitar que ocorra um novo get de dados para a api com valores
    nulos, fazendo isso evito erros de retornos da api.*/
    if (newValue != null && newValue != '') {
      setState(() {
        input1 = num.parse(newValue);
        if (notError) {
          notError = false;
          _text2.value = TextEditingValue(text: input1.toString());
        }
        if (resetInputs) {
          resetInputs2 = true;
          input2 = 0;
          _text1.value = TextEditingValue(text: '');
        }
        resetInputs = false;
      });
      input2 = await alterarValorInput2(input1, pais1, pais2);
      setState(() {
        _text1.value = TextEditingValue(text: input2.toString());
      });
    }
/*Eu estava tendo muito problema com os valores, ficando sempre no útlimo valor quando não tinha nada, ou seja,
quando eu apagava e no input não sobrava nada o outro input ficava com o último valor da conversão. 
Então, para isso eu fiz essa condição para que  fosse evitado de ser exibido, além disso, a função foi preparada
para caso a pessoa saia do input2 e comece alterar o valor do texto nesse campo, para então, evitar erros de lei-
tura pelo usuário */
    else {
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      notError = true;
    }
  }

/*Para não ser redudante, foi realizado o mesmo aqui, no entanto, relacionado ao segundo input.
Caso escolha o sentido do input2 então vamos zerar o input1 para realizar novas conversões.*/
  void mudarInput2(newValue) async {
    if (newValue != null && newValue != '') {
      setState(() {
        input2 = num.parse(newValue);
        if (notError) {
          notError = false;
          _text1.value = TextEditingValue(text: (input2).toString());
        }
        if (resetInputs2) {
          resetInputs = true;
          input1 = 0;
          _text2.value = TextEditingValue(text: '');
        }
        resetInputs = false;
      });
      input1 = await alterarValorInput2(input2, pais2, pais1);
      setState(() {
        _text2.value = TextEditingValue(text: input1.toString());
      });
    } else {
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      notError = true;
    }
  }

//Essa função nada mais é do que uma função para alternar os países selecionados nos respectivos dropDowns
  void alternarValores() {
    setState(() {
      var aux = pais1;
      pais1 = pais2;
      pais2 = aux;
      //Fiz zerar para trazer mais consistência a aplicação.
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      input1 = 0;
      input2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Conversor de moedas",
          ),
        ),
        backgroundColor: Colors.amber[100],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dropDownsComponent(
                    pais1,
                    listaPaises,
                    (newValue) => {
                          setState(() {
                            pais1 = newValue;
                          })
                        }),
                inputComponent(
                    inputController: _text2, changeInput: mudarInput1),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonChangeComponent(() => alternarValores()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dropDownsComponent(
                    pais2,
                    listaPaises,
                    (newValue) => {
                          setState(() {
                            pais2 = newValue;
                          })
                        }),
                inputComponent(
                    inputController: _text1, changeInput: mudarInput2),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
