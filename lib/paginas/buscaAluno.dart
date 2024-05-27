import 'package:flutter/material.dart';
import 'package:sprint2/widgets/appBar.dart';
import 'package:sprint2/paginas/listaAluno.dart';

class BuscaAluno extends StatefulWidget {
  const BuscaAluno({Key? key}) : super(key: key);

  @override
  State<BuscaAluno> createState() => _BuscaAlunoState();
}

class _BuscaAlunoState extends State<BuscaAluno> {
  TextEditingController textController = TextEditingController();
  void _busca() {
    String nomeAluno = textController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListaAluno(nomeAluno: nomeAluno)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: AppBarM(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          const SizedBox(height: 150),
          const Text(
            "Busca por aluno:",
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
                hintText: 'Digite o nome do Aluno',
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
