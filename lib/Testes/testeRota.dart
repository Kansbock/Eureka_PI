import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sprint2/backend/buscarloc.dart';
import 'package:sprint2/backend/buscas.dart';
import 'package:sprint2/backend/mapa.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // CA-1
  //Dado que quero visitar um estande específico
  test("Testar para ver se ele encontra a rota.", () async {
    //Quando estiver na página do mapa
    List<List<int>> grid = List.generate(
      30,
      (_) => List<int>.filled(60, 1),
    );
    AcharObstaculos(grid, -1);
    Pontos inicio = Pontos(10, 20);
    if (grid[inicio.x][inicio.y] == -1) {
      inicio = acharCaminhoLivre(inicio, grid);
    }
    List destino = await BuscarCoordenadas("100");
    List<Pontos> caminho = rota(grid, inicio, Pontos(int.parse(destino[0]["x"]), int.parse(destino[0]["y"])));
    //Então mostrar melhor opção de trajeto até o estande desejado
    expect(caminho.isNotEmpty, true);
  });
  // CA-2
  //Dado que quero visitar um estande específico
  test("Testar para ver se ele encontra a rota mesmo não estando no ginásio.", () async {
    //Quando estiver na página do mapa não estando fisicamente no ginásio
    List<List<int>> grid = List.generate(
      30,
      (_) => List<int>.filled(60, 1),
    );
    AcharObstaculos(grid, -1);
    Coordenadas loc = Coordenadas();
    await loc.getPosicao();
    Pontos inicio = loc.converterLoc(loc.lat, loc.long);
    if (grid[inicio.x][inicio.y] == -1) {
      inicio = acharCaminhoLivre(inicio, grid);
    }
    List destino = await BuscarCoordenadas("100");
    List<Pontos> caminho = rota(grid, inicio, Pontos(int.parse(destino[0]["x"]), int.parse(destino[0]["y"])));
    //Então mostrar melhor opção de trajeto da entrada até o estande desejado
    expect(caminho.isNotEmpty, true);
  });
}
