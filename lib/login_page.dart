import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? token;
  String? message;

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.5:8080/Login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        token = responseData['token'];
        message = null;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(token: token!),
        ),
      );
    } else {
      setState(() {
        token = null;
        message = responseData['mensagem'];
      });

      if (message != null) {
        _showAlertDialog(context, 'Login Error', message!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Usuário'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
              SizedBox(height: 20),
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
