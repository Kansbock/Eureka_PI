import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint2/paginas/novaSenha.dart';
import 'package:sprint2/widgets/appBar.dart';

class CodigoSeguranca extends StatefulWidget {
  final String email;
  final int codigo;
  const CodigoSeguranca({super.key, required this.codigo, required this.email});

  @override
  State<CodigoSeguranca> createState() => _CodigoSegurancaState();
}

class _CodigoSegurancaState extends State<CodigoSeguranca> {
  bool _codigoErrado = false;
  bool _codigoVazio = false;
  final TextEditingController _codigoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: AppBarM(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "Código de Segurança",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(125, 20, 125, 20),
                child: Text(
                  "Informe o código de segurança enviado ao seu email",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _codigoController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: _codigoErrado
                        ? 'Código incorreto'
                        : _codigoVazio
                            ? 'Digite o código'
                            : 'Digite o código de segurança',
                    hintStyle: TextStyle(
                        color: _codigoErrado || _codigoVazio
                            ? Colors.red
                            : Colors.grey),
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _codigoErrado || _codigoVazio
                              ? Colors.red
                              : Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                          color: _codigoErrado || _codigoVazio
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
                      var codigoDigitado = _codigoController.text;
                      if (codigoDigitado == "") {
                        setState(() {
                          _codigoVazio = true;
                        });
                      } else {
                        if (int.parse(codigoDigitado) == widget.codigo) {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  NovaSenha(email: widget.email)));
                        } else {
                          setState(() {
                            _codigoErrado = true;
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
    );
  }
}
