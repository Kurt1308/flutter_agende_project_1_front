import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  bool isButtonEnabled = false;

  List<int> dias = List.generate(31, (index) => index + 1);
  List<String> meses = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];
  List<int> anos = List.generate(38, (index) => index + 2023);

  String selectedDia = '01';
  String selectedMes = 'Jan';
  String selectedAno = '2023';

  @override
  void initState() {
    super.initState();

    senhaController.addListener(validateFields);
    confirmarSenhaController.addListener(validateFields);
  }

  void validateFields() {
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    setState(() {
      isButtonEnabled = senha.isNotEmpty &&
          confirmarSenha.isNotEmpty &&
          senha == confirmarSenha;
    });
  }

  @override
  void dispose() {
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputTextStyle = Theme.of(context).textTheme.bodyText1!;
    final TextStyle labelStyle = inputTextStyle.copyWith(
      color: Colors.grey,
      fontSize:
          inputTextStyle.fontSize! + 2.0, // Aumentando a fonte em 2 pontos
      fontWeight: FontWeight.normal, // Removendo o negrito
    );

    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Primeiro nome'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Último nome'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nascimento:',
                      style: labelStyle, // Utilizando o novo estilo do label
                    ),
                    Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedDia,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDia = newValue!;
                            });
                          },
                          items:
                              dias.map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString().padLeft(2, '0'),
                              child: Text(
                                value.toString().padLeft(2, '0'),
                                style: inputTextStyle,
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<String>(
                          value: selectedMes,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMes = newValue!;
                            });
                          },
                          items: meses
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: inputTextStyle,
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<String>(
                          value: selectedAno,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedAno = newValue!;
                            });
                          },
                          items:
                              anos.map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                value.toString(),
                                style: inputTextStyle,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Código estabelecimento'),
                ),
                TextFormField(
                  controller: senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                TextFormField(
                  controller: confirmarSenhaController,
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  obscureText: true,
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
