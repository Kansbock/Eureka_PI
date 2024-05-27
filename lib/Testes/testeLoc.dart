import 'package:flutter/material.dart';
import 'package:sprint2/backend/buscarloc.dart';
import 'package:sprint2/backend/mapa.dart';
import 'package:test/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("", () {
    Coordenadas loc = Coordenadas();
    var localizacao = loc.converterLoc(-23.6468175, -46.5730710);
    expect(localizacao.x < 30 && localizacao.x >= 0 && localizacao.y < 60 && localizacao.y >= 0, true );
  });
  test("", () async {
    Coordenadas loc = Coordenadas();
    await loc.getPosicao();
    var localizacao = loc.converterLoc(loc.lat, loc.long);
    expect(localizacao, Pontos(24, 59));
  });
}
