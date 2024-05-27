import 'package:flutter/material.dart';
import 'package:sprint2/paginas/listaProjetos.dart';
import 'package:sprint2/widgets/appBar.dart';

class BuscaProjeto extends StatefulWidget {
  const BuscaProjeto({super.key});

  @override
  State<BuscaProjeto> createState() => _BuscaAlunoState();
}

class _BuscaAlunoState extends State<BuscaProjeto> {
  TextEditingController textController = TextEditingController();
  void _busca() {
    String nomeProjeto = textController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListaProjeto(nomeProjeto: nomeProjeto)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: const AppBarM(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(height: 150),
          const Text(
            "Busca por projeto:",
            style: TextStyle(fontSize: 30, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: textController,
              onSubmitted: (value) {
                _busca();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Digite o nome do Projeto',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 180),
          Image.asset(
            "assets/mauaPequeno.png",
            width: 137,
            height: 95,
          )
        ],
      ),
    );
  }
}
