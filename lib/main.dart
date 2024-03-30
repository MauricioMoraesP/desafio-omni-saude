import 'package:desafio/models/button_change_comp.dart';
import 'package:desafio/models/drop_downs.dart';
import 'package:desafio/models/input_component.dart';
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
  List<String> _listaPaises = [];
  //Valores padrões para ficar selecionado o primeiro e o segundo dropdown
  String _pais1 = 'USD';
  String _pais2 = 'EUR';
  //Valores que são atualizados conforme eu faço alterações no meu textField
  num _input1 = 0.0;
  num _input2 = 0.0;
//Controlador para zerar o texto de um dos inputs
  bool _resetInputs = true;
  bool _resetInputs2 = true;

//Variável para gerir e evitar realizar fetch sem valores definidos
  bool _notError = false;

/*Essa função abstrata é uma sobrescrita que garante que uma determinada declaração seja chamada na rederização
 da árvore de componentes, como os dropDowns têm que ser alimentados então precisa ser chamada logo de inicio
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllCountry();
  }

/*
Essa função é para dados assincronos criados no composable e receber os dados dos paises que irão compor o
dropdown. Como a variável valores irá mudar, então precisamos colocar ela dentro de um setState.
 */
  void _getAllCountry() async {
    final response = await getAllPaises();
    setState(() {
      _listaPaises = response;
    });
  }

/*
Esta função eu utilizei uma abordagem diferente, na qual tratei a função com retorno de uma promise, pois, por
algum mo'tivo que eu não entendi, estava apontando erro por conta do retorno da função importada, aí tive que 
ajustar a função para que retornasse os devidos valores. */
  Future<num> _alterarValor_Input2(
      num valor, String _pais1, String _pais2) async {
    final response = await getConverter(_pais1, _pais2, valor);
    return response;
  }

/*
Esta função foi criada no intuito de atualizar  de acordo com a conversão _input2 e com isso o valor 
do textField2.
 */
  void _mudarInput1(newValue) async {
    /*Caso ocorra do meu novo valor ser nada ' ', evitar que ocorra um novo get de dados para a api com valores
    nulos, fazendo isso evito erros de retornos da api.*/
    if (newValue != null && newValue != '') {
      setState(() {
        _input1 = num.parse(newValue);
        if (_notError) {
          _notError = false;
          _text2.value = TextEditingValue(text: _input1.toString());
        }
        if (_resetInputs) {
          _resetInputs2 = true;
          _input2 = 0;
          _text1.value = TextEditingValue(text: '');
        }
        _resetInputs = false;
      });
      _input2 = await _alterarValor_Input2(_input1, _pais1, _pais2);
      setState(() {
        _text1.value = TextEditingValue(text: _input2.toString());
      });
    }
/*Eu estava tendo muito problema com os valores, ficando sempre no útlimo valor quando não tinha nada, ou seja,
quando eu apagava e no input não sobrava nada o outro input ficava com o último valor da conversão. 
Então, para isso eu fiz essa condição para que  fosse evitado de ser exibido, além disso, a função foi preparada
para caso a pessoa saia do _input2 e comece alterar o valor do texto nesse campo, para então, evitar erros de lei-
tura pelo usuário */
    else {
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      _input1 = 0;
      _input2 = 0;
      _notError = true;
    }
  }

/*Para não ser redudante, foi realizado o mesmo aqui, no entanto, relacionado ao segundo input.
Caso escolha o sentido do _input2 então vamos zerar o _input1 para realizar novas conversões.*/
  void _mudar_Input2(newValue) async {
    if (newValue != null && newValue != '') {
      setState(() {
        _input2 = num.parse(newValue);
        if (_notError) {
          _notError = false;
          _text1.value = TextEditingValue(text: (_input2).toString());
        }
        if (_resetInputs2) {
          _resetInputs = true;
          _input1 = 0;
          _text2.value = TextEditingValue(text: '');
        }
        _resetInputs = false;
      });
      _input1 = await _alterarValor_Input2(_input2, _pais2, _pais1);
      setState(() {
        _text2.value = TextEditingValue(text: _input1.toString());
      });
    } else {
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      _notError = true;
      _input1 = 0;
      _input2 = 0;
    }
  }

//Essa função nada mais é do que uma função para alternar os países selecionados nos respectivos dropDowns
  void _alternarValores() {
    setState(() {
      var aux = _pais1;
      _pais1 = _pais2;
      _pais2 = aux;
      //Fiz zerar para trazer mais consistência a aplicação.
      _text1.value = TextEditingValue(text: '');
      _text2.value = TextEditingValue(text: '');
      _input1 = 0;
      _input2 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Center(
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
                DropDowns(
                    _pais1,
                    _listaPaises,
                    (newValue) => {
                          setState(() {
                            _pais1 = newValue;
                          })
                        }),
                InputComponent(
                  inputController: _text2,
                  changeInput: _mudarInput1,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonChangeComponent(() => _alternarValores()),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropDowns(
                    _pais2,
                    _listaPaises,
                    (newValue) => {
                          setState(() {
                            _pais2 = newValue;
                          })
                        }),
                InputComponent(
                  inputController: _text1,
                  changeInput: _mudar_Input2,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
