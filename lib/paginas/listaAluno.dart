import 'package:flutter/material.dart';
import 'package:sprint2/backend/buscas.dart';
import 'package:sprint2/paginas/paginaAluno.dart';
import 'package:sprint2/widgets/appBar.dart';

class ListaAluno extends StatefulWidget {
  final String nomeAluno;
  const ListaAluno({super.key, required this.nomeAluno});

  @override
  _ListaAlunoState createState() => _ListaAlunoState();
}

class _ListaAlunoState extends State<ListaAluno> {
  late Future<List<dynamic>> alunos;

  @override
  void initState() {
    super.initState();
    alunos = BuscarAluno(widget.nomeAluno);
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
                "Lista de Alunos:",
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
                      'Aluno não encontrado.',
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
                              builder: (cotext) => PaginaAluno(
                                nome: snapshot.data![index]['nomeAluno'],
                                projeto: snapshot.data![index]['tituloTrabalho'],
                                estande: snapshot.data![index]['numeroEstande'],
                                desc: snapshot.data![index]['descricaoTrabalho'],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              snapshot.data![index]['nomeAluno'],
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
