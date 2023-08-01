import 'package:flutter/material.dart';

class CadastroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Padding(
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
                decoration: InputDecoration(labelText: 'Idade'),
              ),
              SizedBox(height: 32.0), // Espaçamento vertical de 2 cm
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Volta para a página de login
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
