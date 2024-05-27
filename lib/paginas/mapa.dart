import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprint2/backend/buscarloc.dart';
import 'package:sprint2/backend/mapa.dart';

class Mapa extends StatefulWidget {
  final Pontos destino;

  const Mapa({super.key, required this.destino});
  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  static const int linhas = 30;
  static const int colunas = 60;
  static const int obstaculos = -1;
  static Pontos inicio = Pontos(0, 0);

  List<List<int>> grid = List.generate(
    linhas,
    (_) => List<int>.filled(colunas, 1),
  );

  List<Pontos> path = [];

  @override
  void initState() {
    super.initState();
    AcharObstaculos(grid, obstaculos);

    Coordenadas loc = Coordenadas();
    loc.getPosicao().then((_) {
      setState(() {
        inicio = loc.converterLoc(loc.lat, loc.long);
        if (grid[inicio.x][inicio.y] == obstaculos) {
          inicio = acharCaminhoLivre(inicio, grid);
        }
        path = rota(grid, inicio, widget.destino);
      });
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 41, 141, 1),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(50),
          minScale: 0.5,
          maxScale: 2.5,
          child: Stack(
            children: [
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  setState(() {
                    final cellWidth = screenSize.width / colunas;
                    final cellHeight = screenSize.height / linhas;
                    final int x =
                        (details.localPosition.dy / cellHeight).floor();
                    final int y =
                        (details.localPosition.dx / cellWidth).floor();
                    Pontos destinoNovo = Pontos(x, y);
                    if (grid[x][y] == obstaculos) {
                      destinoNovo = acharCaminhoLivre(Pontos(x, y), grid);
                    }
                    print(destinoNovo);
                    path = rota(grid, inicio, destinoNovo);
                  });
                },
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  color: Colors.white,
                  child: CustomPaint(
                    painter: GridPainter(grid, path),
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
