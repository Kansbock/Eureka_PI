import 'package:flutter/material.dart';
import 'package:sprint2/backend/mapa.dart';
import 'package:sprint2/paginas/buscaAluno.dart';
import 'package:sprint2/paginas/buscaProjeto.dart';
import 'package:sprint2/paginas/mapa.dart';
import 'package:sprint2/widgets/appBar.dart';

class tipoBusca extends StatelessWidget {
  const tipoBusca({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarM(),
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  "Busca",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(125, 30, 125, 0),
                  child: Text(
                    "Escolha um método de busca",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(0, 26, 114, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const BuscaAluno()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(75, 15, 75, 15),
                        child: Text(
                          "ALUNO",
                          style: TextStyle(
                              color: Color.fromRGBO(216, 207, 207, 1),
                              fontSize: 20),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(0, 26, 114, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const BuscaProjeto()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(65, 15, 65, 15),
                        child: Text(
                          "PROJETO",
                          style: TextStyle(
                              color: Color.fromRGBO(216, 207, 207, 1),
                              fontSize: 20),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(0, 26, 114, 1)),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  Mapa(destino: Pontos(24, 59),)));
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                        child: Text(
                          "MAPA",
                          style: TextStyle(
                              color: Color.fromRGBO(216, 207, 207, 1),
                              fontSize: 20),
                        ),
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: Image.asset(
                      "assets/mauaPequeno.png",
                      width: 137,
                      height: 95,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
