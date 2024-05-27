import 'package:flutter/material.dart';
import 'package:sprint2/backend/buscas.dart';
import 'package:sprint2/paginas/paginaProjeto.dart';
import 'package:sprint2/widgets/appBar.dart';

class ListaProjeto extends StatefulWidget {
  final String nomeProjeto;
  const ListaProjeto({super.key, required this.nomeProjeto});

  @override
  _ListaProjetoState createState() => _ListaProjetoState();
}

class _ListaProjetoState extends State<ListaProjeto> {
  late Future<List<dynamic>> alunos;

  @override
  void initState() {
    super.initState();
    alunos = BuscarProjeto(widget.nomeProjeto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 41, 141, 1),
      appBar: AppBarM(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "Lista de Projetos:",
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: alunos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text(
                      'Projeto não existe.',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () {
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (cotext) => PaginaProjeto(
                                titulo: snapshot.data![index]['tituloTrabalho'],
                                estande: snapshot.data![index]['numeroEstande'],
                                orientador: snapshot.data![index]['orientador'],
                                desc: snapshot.data![index]['descricaoTrabalho'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              snapshot.data![index]['tituloTrabalho'],
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
