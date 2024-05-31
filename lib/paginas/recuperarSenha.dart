import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sprint2/backend/contas.dart';
import 'package:sprint2/paginas/codigoSeguranca.dart';
import 'package:sprint2/widgets/appBar.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  bool _emailErrado = false;
  bool _emailVazio = false;
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: AppBarM(),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Recuperar senha",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(125, 20, 125, 20),
                  child: Text(
                    "Informe o email para o qual deseja redefinir sua senha",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
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
                              ? 'Digite um email'
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
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(0, 26, 114, 1)),
                      ),
                      onPressed: () async {
                        var email = _emailController.text;
                        if (email == "") {
                          setState(() {
                            _emailVazio = true;
                          });
                        } else {
                          var data = await BuscarConta(email);
                          if (data.isEmpty) {
                            setState(() {
                              _emailErrado = true;
                            });
                          } else {
                            var random = Random();
                            int numeroAleatorio =
                                100000 + random.nextInt(900000);
                            print(numeroAleatorio);
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  CodigoSeguranca(email: email, codigo: numeroAleatorio)));
                          }
                        }
                        Future.delayed(const Duration(seconds: 10), () {
                          setState(() {
                            _emailErrado = false;
                            _emailVazio = false;
                          });
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                        child: Text(
                          "Enviar email",
                          style: TextStyle(
                              color: Color.fromRGBO(216, 207, 207, 1),
                              fontSize: 20),
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 160, 0, 0),
                    child: Image.asset(
                      "assets/mauaPequeno.png",
                      width: 137,
                      height: 95,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
