import 'package:flutter/material.dart';
import 'cadastro_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true, // Centraliza o título na AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 32.0), // Aumenta o espaçamento horizontal para 2 cm
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Usuário'),
              ),
              SizedBox(height: 10), // Espaço vertical entre os campos de input
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(
                  height:
                      20), // Espaço vertical entre os campos de input e o botão
              ElevatedButton(
                onPressed: () {
                  // Coloque aqui a lógica de autenticação, se desejar
                },
                child: Text('Entrar'),
              ),
              SizedBox(height: 20), // Espaço vertical entre os botões
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroPage()),
                  );
                },
                child:
                    Text('Cadastre-se', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
