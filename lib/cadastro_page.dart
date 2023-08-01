import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();
  bool isButtonEnabled = false;

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
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 32.0), // Espaçamento horizontal de 2 cm
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Data de nascimento'),
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Código estabelecimento'),
                ),
                TextFormField(
                  controller: senhaController,
                  decoration:
                      InputDecoration(labelText: 'Senha'), // Campo de senha
                  obscureText: true, // Esconde o texto digitado
                ),
                TextFormField(
                  controller: confirmarSenhaController,
                  decoration: InputDecoration(
                      labelText: 'Confirmar senha'), // Campo de confirmar senha
                  obscureText: true, // Esconde o texto digitado
                ),
                SizedBox(height: 32.0), // Espaçamento vertical de 2 cm
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          Navigator.pop(
                              context); // Volta para a página de login
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
