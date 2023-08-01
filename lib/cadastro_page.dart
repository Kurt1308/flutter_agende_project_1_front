import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  TextEditingController primeiroNomeController = TextEditingController();
  TextEditingController ultimoNomeController = TextEditingController();
  TextEditingController codigoEstabelecimentoController =
      TextEditingController();
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

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();

    senhaController.addListener(validateFields);
    confirmarSenhaController.addListener(validateFields);
    emailController.addListener(validateFields);
    dataNascimentoController.addListener(validateFields);
    primeiroNomeController.addListener(validateFields);
    ultimoNomeController.addListener(validateFields);
    codigoEstabelecimentoController.addListener(validateFields);
  }

  String? validateEmail(String? value) {
    if (value != null && !emailRegex.hasMatch(value)) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? validateSenha(String? value) {
    if (value != null && (value.isEmpty || value.length < 6)) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validateConfirmarSenha(String? value) {
    if (value != null && value != senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value != null && value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? validateCodigoEstabelecimento(String? value) {
    if (value != null &&
        !value.isEmpty &&
        !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'O código deve conter apenas números';
    }
    return null;
  }

  void validateFields() {
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;
    final email = emailController.text;
    final primeiroNome = primeiroNomeController.text;
    final ultimoNome = ultimoNomeController.text;
    final codigoEstabelecimento = codigoEstabelecimentoController.text;

    setState(() {
      isButtonEnabled = senha.isNotEmpty &&
          confirmarSenha.isNotEmpty &&
          senha == confirmarSenha &&
          (email.isEmpty || emailRegex.hasMatch(email)) &&
          (dataNascimentoController.text.isEmpty ||
              dataNascimentoController.text.trim().isNotEmpty) &&
          validateName(primeiroNome) == null &&
          validateName(ultimoNome) == null &&
          validateCodigoEstabelecimento(codigoEstabelecimento) == null;
    });
  }

  String nameFormatter(String text) {
    if (text.isEmpty) return text;
    return text.substring(0, 1).toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  void dispose() {
    senhaController.dispose();
    confirmarSenhaController.dispose();
    emailController.dispose();
    dataNascimentoController.dispose();
    primeiroNomeController.dispose();
    ultimoNomeController.dispose();
    codigoEstabelecimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputTextStyle = Theme.of(context).textTheme.bodyText1!;
    final TextStyle labelStyle = inputTextStyle.copyWith(
      color: Colors.grey,
      fontSize: inputTextStyle.fontSize! + 2.0,
      fontWeight: FontWeight.normal,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Primeiro nome'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    controller: primeiroNomeController,
                    onChanged: (value) {
                      primeiroNomeController.text = nameFormatter(value);
                      primeiroNomeController.selection =
                          TextSelection.fromPosition(
                        TextPosition(
                            offset: primeiroNomeController.text.length),
                      );
                      validateFields();
                    },
                    validator: validateName,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Último nome'),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    controller: ultimoNomeController,
                    onChanged: (value) {
                      ultimoNomeController.text = nameFormatter(value);
                      ultimoNomeController.selection =
                          TextSelection.fromPosition(
                        TextPosition(offset: ultimoNomeController.text.length),
                      );
                      validateFields();
                    },
                    validator: validateName,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'E-mail'),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nascimento:',
                        style: labelStyle,
                      ),
                      Row(
                        children: [
                          DropdownButton<String>(
                            value: selectedDia,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDia = newValue!;
                                if (dataNascimentoController.text.isNotEmpty) {
                                  validateFields();
                                }
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
                                if (dataNascimentoController.text.isNotEmpty) {
                                  validateFields();
                                }
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
                                if (dataNascimentoController.text.isNotEmpty) {
                                  validateFields();
                                }
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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    controller: codigoEstabelecimentoController,
                    validator: validateCodigoEstabelecimento,
                  ),
                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: validateSenha,
                  ),
                  TextFormField(
                    controller: confirmarSenhaController,
                    decoration: InputDecoration(labelText: 'Confirmar senha'),
                    obscureText: true,
                    validator: validateConfirmarSenha,
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
      ),
    );
  }
}
