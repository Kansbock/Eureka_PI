import 'package:flutter/material.dart';
import 'package:sprint2/backend/contas.dart';
import 'package:sprint2/widgets/appBar.dart';

class NovaSenha extends StatefulWidget {
  final String email;
  const NovaSenha({super.key, required this.email});

  @override
  State<NovaSenha> createState() => _NovaSenhaState();
}

class _NovaSenhaState extends State<NovaSenha> {
  bool _senhaTrocada = false;
  bool _senhaVazio = false;
  bool _senhaPequena = false;
  bool _senhaCVazio = false;
  bool _senhasDiferentes = false;
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaCController = TextEditingController();
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
                    "Informe a nova senha",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: _senhaVazio
                          ? 'Digite sua senha'
                          : _senhaPequena
                              ? 'Senha muito pequena'
                              : _senhaTrocada? 'Senha alterada com sucesso!' 
                              : 'Senha',
                      hintStyle: TextStyle(
                          color: _senhaVazio || _senhaPequena
                              ? Colors.red
                              : _senhaTrocada? Colors.green
                              : Colors.grey),
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: _senhaVazio ? Colors.red :_senhaTrocada? Colors.green
                              : Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: _senhaVazio ? Colors.red :_senhaTrocada? Colors.green
                              : Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextField(
                    controller: _senhaCController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: _senhaCVazio
                          ? 'Confirme a sua senha'
                          : _senhasDiferentes
                              ? 'Senhas diferentes'
                              : 'Confirmar senha',
                      hintStyle: TextStyle(
                          color: _senhaCVazio
                              ? Colors.red
                              : _senhasDiferentes
                                  ? Colors.red
                                  : Colors.grey),
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: _senhaCVazio ? Colors.red : Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: _senhaCVazio ? Colors.red : Colors.grey),
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
                        setState(() {
                          _senhaTrocada = false;
                          _senhaVazio = false;
                          _senhaPequena = false;
                          _senhaCVazio = false;
                          _senhasDiferentes = false;
                        });
                        String senha = _senhaController.text;
                        String senhaC = _senhaCController.text;
                        if (senha.length < 6) {
                          _senhaPequena = true;
                        }
                        if (senha == "") {
                          _senhaVazio = true;
                        }
                        if (senhaC == "") {
                          _senhaCVazio = true;
                        }
                        if (senha != senhaC) {
                          _senhasDiferentes = true;
                        }
                        if (!_senhaPequena &&
                            !_senhaVazio &&
                            !_senhaCVazio &&
                            !_senhasDiferentes) {
                          bool atualizacao =
                              await mudarSenha(widget.email, senha);
                          if (atualizacao) {
                            setState(() {
                              _senhaCController.clear();
                              _senhaController.clear();
                              _senhaTrocada = true;
                            });
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                        child: Text(
                          "Confirmar",
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
