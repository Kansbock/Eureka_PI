import 'package:flutter/material.dart';
import 'package:sprint2/backend/contas.dart';
import 'package:sprint2/paginas/cadastro.dart';
import 'package:sprint2/paginas/recuperarSenha.dart';
import 'package:sprint2/paginas/tipoBusca.dart';
import 'package:sprint2/widgets/appBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _Clicado = false;
  bool _Clicado2 = false;
  bool _senhaVazia = false;
  bool _senhaErrada = false;
  bool _emailVazio = false;
  bool _emailErrado = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: const AppBarM(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "assets/maua.png",
                width: 278,
                height: 172,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _emailErrado
                        ? 'Email incorreto'
                        : _emailVazio
                            ? 'Digite o email'
                            : 'Digite seu email',
                    hintStyle: TextStyle(
                        color: _emailErrado || _emailVazio
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _emailErrado || _emailVazio
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _emailErrado || _emailVazio
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _senhaVazia
                        ? 'Senha não digitada'
                        : _senhaErrada
                            ? 'Senha incorreta'
                            : 'Digite sua senha',
                    hintStyle: TextStyle(
                        color: _senhaVazia || _senhaErrada
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaVazia || _senhaErrada
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _senhaVazia || _senhaErrada
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(0, 26, 114, 1)),
                  ),
                  onPressed: () async {
                    _emailVazio = false;
                    _senhaVazia = false;
                    _senhaErrada = false;
                    _emailErrado = false;
                    String email = _emailController.text;
                    String senha = _passwordController.text;
                    if (email != "") {
                      var data = await BuscarConta(email);
                      if (data != null && data.isNotEmpty) {
                        if (senha.isEmpty) {
                          setState(() {
                            _senhaVazia = true;
                          });
                          Future.delayed(const Duration(seconds: 10), () {
                            setState(() {
                              _senhaVazia = false;
                            });
                          });
                          _passwordController.clear();
                        } else if (data[0]["senha"] != senha) {
                          setState(() {
                            _senhaErrada = true;
                          });
                          _passwordController.clear();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => tipoBusca()),
                          );
                        }
                      } else {
                        setState(() {
                          _emailErrado = true;
                        });
                        _emailController.clear();
                        _passwordController.clear();
                      }
                    } else {
                      _emailVazio = true;
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                          color: Color.fromRGBO(216, 207, 207, 1),
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                    setState(() {
                      _Clicado = true;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      setState(() {
                        _Clicado = false;
                      });
                    });
                  },
                  child: Text(
                    "Criar conta",
                    style: TextStyle(
                      fontSize: 20,
                      color: _Clicado ? Colors.blue : Colors.white,
                      decoration: _Clicado
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecuperarSenha()),
                    );
                    setState(() {
                      _Clicado2 = true;
                    });
                    Future.delayed(const Duration(milliseconds: 200), () {
                      setState(() {
                        _Clicado2 = false;
                      });
                    });
                  },
                  child: Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(
                      fontSize: 20,
                      color: _Clicado2 ? Colors.blue : Colors.white,
                      decoration: _Clicado2
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
