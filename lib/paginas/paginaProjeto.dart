import 'package:flutter/material.dart';
import 'package:sprint2/backend/buscas.dart';
import 'package:sprint2/backend/mapa.dart';

import 'package:sprint2/paginas/mapa.dart';
import 'package:sprint2/widgets/appBar.dart';

class PaginaProjeto extends StatefulWidget {
  final String titulo;
  final String estande;
  final String orientador;
  final String desc;

  const PaginaProjeto({
    Key? key,
    required this.estande,
    required this.desc,
    required this.titulo,
    required this.orientador,
  }) : super(key: key);

  @override
  _PaginaProjetoState createState() => _PaginaProjetoState();
}

class _PaginaProjetoState extends State<PaginaProjeto> {
  late Future<List<dynamic>> coordenadas;
  @override
  void initState() {
    super.initState();
    coordenadas = BuscarCoordenadas(widget.estande);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: const AppBarM(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color.fromRGBO(0, 26, 114, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      widget.titulo,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color.fromRGBO(0, 26, 114, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(
                      children: [
                        Text(
                          "Estande: ${widget.estande}",
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Orientador: ${widget.orientador}",
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Descrição: ${widget.desc}",
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
                  onPressed: () {
                    coordenadas.then((value) {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  Mapa(destino: Pontos(int.parse(value[0]["x"]), int.parse(value[0]["y"])),)));
                    });
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                    child: Text(
                      "LOCALIZAR",
                      style: TextStyle(
                          color: Color.fromRGBO(216, 207, 207, 1),
                          fontSize: 20),
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
