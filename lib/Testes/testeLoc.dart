import 'package:flutter/material.dart';
import 'package:sprint2/backend/buscarloc.dart';
import 'package:sprint2/backend/mapa.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //CA-1
  //Dado que quero que o aplicativo determine minha posição atual 
  test("Testar a determinação da localização.", () {
    //Quando estou fisicamente no ginásio
    Coordenadas loc = Coordenadas();
    var localizacao = loc.converterLoc(-23.6468175, -46.5730710);
    //Então ele me mostra minha localização aproximada dentro do mapa.
    expect(localizacao.x < 30 && localizacao.x >= 0 && localizacao.y < 60 && localizacao.y >= 0, true );
  });
  //CA-2
  //Dado que quero que o aplicativo determine minha posição atual 
  test("Testar para ver se ao obter coordenadas fora do ginásio ele retorna as coordenadas da entrada.", () async {
    //Quando não estou fisicamente no ginásio
    Coordenadas loc = Coordenadas();
    await loc.getPosicao();
    var localizacao = loc.converterLoc(loc.lat, loc.long);
    //Então ele mostra minha localização como se eu estivesse na entrada do ginásio
    expect(localizacao, Pontos(24, 59));
  });
}
