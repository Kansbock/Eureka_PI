import 'package:flutter/material.dart';

void AcharObstaculos(List<List<int>> grid, int obstaculos) {
  const obstacleCoords = [
    [28, 29, 3, 53],
    [22, 25, 3, 17],
    [22, 25, 21, 35],
    [22, 25, 38, 52],
    [16, 19, 3, 17],
    [16, 19, 21, 35],
    [16, 19, 38, 52],
    [10, 13, 3, 17],
    [10, 13, 21, 35],
    [10, 13, 38, 52],
    [4, 7, 4, 16],
    [4, 7, 21, 35],
    [4, 7, 38, 52],
    [0, 1, 3, 17],
    [0, 1, 21, 35],
    [0, 1, 38, 50],
  ];

  for (final coord in obstacleCoords) {
    for (int i = coord[0]; i <= coord[1]; i++) {
      for (int j = coord[2]; j <= coord[3]; j++) {
        grid[i][j] = obstaculos;
      }
    }
  }
}

Pontos acharCaminhoLivre(Pontos point, List<List<int>> grid) {
  int i = 0;
  while (true) {
    if (point.x + i < 30 && grid[point.x + i][point.y] != -1) {
      return Pontos(point.x + i, point.y);
    }
    if (point.x - i >= 0 && grid[point.x - i][point.y] != -1) {
      return Pontos(point.x - i, point.y);
    }
    if (point.y + i < 60 && grid[point.x][point.y + i] != -1) {
      return Pontos(point.x, point.y + i);
    }
    if (point.y - i >= 0 && grid[point.x][point.y - i] != -1) {
      return Pontos(point.x, point.y - i);
    }
    i++;
  }
}

List<Pontos> AcharVizinho(Pontos point, List<List<int>> grid) {
  final vizinhos = <Pontos>[];

  if (point.x > 0 && grid[point.x - 1][point.y] != -1) {
    vizinhos.add(Pontos(point.x - 1, point.y));
  }
  if (point.x < 30 - 1 && grid[point.x + 1][point.y] != -1) {
    vizinhos.add(Pontos(point.x + 1, point.y));
  }
  if (point.y > 0 && grid[point.x][point.y - 1] != -1) {
    vizinhos.add(Pontos(point.x, point.y - 1));
  }
  if (point.y < 60 - 1 && grid[point.x][point.y + 1] != -1) {
    vizinhos.add(Pontos(point.x, point.y + 1));
  }
  

  return vizinhos;
}

int heuristicCostEstimate(Pontos start, Pontos goal) {
  return (start.x - goal.x).abs() + (start.y - goal.y).abs();
}

class GridPainter extends CustomPainter {
  final List<List<int>> grid;
  final List<Pontos> path;

  GridPainter(this.grid, this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / 60;
    final cellHeight = size.height / 30;

    final obstaclePaint = Paint()..color = Colors.transparent;
    final obstaclePaint2 = Paint()..color = Colors.transparent;

    for (var i = 0; i < 30; i++) {
      for (var j = 0; j < 60; j++) {
        if (grid[i][j] == -1) {
          if ((j <= 52 && j >= 38 && i <= 19 && i >= 16) ||
              (j <= 52 && j >= 50 && i <= 25 && i >= 22)) {
            canvas.drawRect(
              Rect.fromLTWH(
                j * cellWidth,
                i * cellHeight,
                cellWidth,
                cellHeight,
              ),
              obstaclePaint2,
            );
          } else {
            canvas.drawRect(
              Rect.fromLTWH(
                j * cellWidth,
                i * cellHeight,
                cellWidth,
                cellHeight,
              ),
              obstaclePaint,
            );
          }
        }
      }
    }

    final pathPaint = Paint()..color = Colors.purple;

    for (var point in path) {
      canvas.drawRect(
        Rect.fromLTWH(
          point.y * cellWidth,
          point.x * cellHeight,
          cellWidth,
          cellHeight,
        ),
        pathPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


class Pontos {
  final int _x;
  final int _y;

  Pontos(this._x, this._y);

  int get x => _x;
  int get y => _y;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pontos &&
          runtimeType == other.runtimeType &&
          _x == other._x &&
          _y == other._y;

  @override
  int get hashCode => _x.hashCode ^ _y.hashCode;

  @override
  String toString() {
    return '($_x, $_y)';
  }
}
List<Pontos> rota(List<List<int>> grid, Pontos inicio, Pontos destino) {
  final openSet = <Pontos>[inicio];
  final closedSet = <Pontos>{};
  final cameFrom = <Pontos, Pontos>{};
  final gScore = <Pontos, int>{inicio: 0};
  final fScore = <Pontos, int>{
    inicio: heuristicCostEstimate(inicio, destino)
  };

  while (openSet.isNotEmpty) {
    openSet.sort((a, b) => (fScore[a] ?? double.infinity)
        .compareTo(fScore[b] ?? double.infinity));
    final current = openSet.removeAt(0);

    if (current == destino) {
      return reconstruirRota(cameFrom, current);
    }

    closedSet.add(current);

    for (final neighbor in AcharVizinho(current, grid)) {
      if (closedSet.contains(neighbor)) continue;

      final tentativeGScore = (gScore[current] ?? 0) + 1;

      if (!openSet.contains(neighbor) ||
          tentativeGScore < (gScore[neighbor] ?? double.infinity)) {
        cameFrom[neighbor] = current;
        gScore[neighbor] = tentativeGScore;
        fScore[neighbor] =
            tentativeGScore + heuristicCostEstimate(neighbor, destino);
        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
        }
      }
    }
  }

  return [];
}

List<Pontos> reconstruirRota(Map<Pontos, Pontos> cameFrom, Pontos current) {
  final List<Pontos> totalPath = [current];
  while (cameFrom.containsKey(current)) {
    current = cameFrom[current]!;
    totalPath.add(current);
  }
  return totalPath.reversed.toList();
}