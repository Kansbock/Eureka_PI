import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sprint2/backend/mapa.dart';

class Coordenadas extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  Coordenadas() {
    getPosicao();
  }

  getPosicao() async {
  try {
    Position posicao = await _posicaoAtual();
    lat = posicao.latitude;
    long = posicao.longitude;
  } catch (e) {
    erro = "Erro ao obter a localização: $e";
    print(erro);
  }
  notifyListeners();
}


  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error("Por favor, habilite a localização.");
    }
    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error("Por favor, habilite a localização.");
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      return Future.error("Por favor, habilite a localização.");
    }
    return await Geolocator.getCurrentPosition();
  }
  Pontos converterLoc(double lat, double lon) {
    // Coordenadas dos cantos do grid
    const lat_0_0 = -23.646533;
    const lon_0_0 = -46.572953;
    const lat_29_59 = -23.6470326;
    const lon_29_59 = -46.5732704;

    double comprimento = lat_0_0 - lat_29_59;
    double altura = lon_0_0 - lon_29_59;
    if (lat > lat_0_0 || lat < lat_29_59 || lon > lon_0_0 || lon < lon_29_59) {
      return Pontos(24, 59);
    }
    double comprimentoAtual = lat_0_0 - lat;
    double alturaAtual = lon_0_0 - lon;
    int x = (comprimentoAtual / (comprimento / 30)).round();
    int y = (alturaAtual / (altura / 60)).round();
    if (x != 0) {
      x--;
    }
    if (y != 0) {
      y--;
    }
    return Pontos(x, y);
}

}
