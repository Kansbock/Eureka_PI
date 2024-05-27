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

  void drawBorderLine(Canvas canvas, Paint paint, double startX, double startY,
      double endX, double endY) {
    canvas.drawLine(
      Offset(startX, startY),
      Offset(endX, endY),
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / 60;
    final cellHeight = size.height / 30;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
      
    final borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i <= 30; i++) {
      final y = i * cellHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    for (var i = 0; i <= 60; i++) {
      final x = i * cellWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    final obstaclePaint = Paint()..color = Colors.transparent;
    final obstaclePaint2 = Paint()..color = Colors.blue;
    for (var i = 0; i < 30; i++) {
      for (var j = 0; j < 60; j++) {
        if (grid[i][j] == -1) {
              if ((j <= 52 && j >= 38 && i <= 19 && i >= 16) || (j <= 52 && j >= 50 && i <= 25 && i >= 22)) {
                  canvas.drawRect(
                      Rect.fromLTWH(
                          j * cellWidth,
                          i * cellHeight,
                          cellWidth,
                          cellHeight,
                      ),
                      obstaclePaint2,
                  );
              }
              else {
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

        if (i == 29) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 25 && j >= 3 && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 19 && j >= 3 && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 13 && j >= 3 && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 7 && j >= 4 && j <= 16) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 1 && j >= 3 && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 25 && j >= 21 && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 19 && j >= 21 && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 13 && j >= 21 && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 7 && j >= 21 && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 1 && j >= 21 && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 25 && j >= 38 && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 19 && j >= 38 && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 13 && j >= 38 && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 7 && j >= 38 && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (i == 1 && j >= 38 && j <= 50) {
          drawBorderLine(canvas, borderPaint, j * cellWidth,
              (i + 1) * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        //bordas superiores

        if (i == 0) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 28 && 3 <= j && j <= 53) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 22 && 3 <= j && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 16 && 3 <= j && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 10 && 3 <= j && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 4 && 4 <= j && j <= 16) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 22 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 16 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 10 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 4 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 22 && 38 <= j && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 16 && 38 <= j && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 10 && 38 <= j && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 4 && 38 <= j && j <= 52) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }

        if (i == 24 && 6 <= j && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 18 && 6 <= j && j <= 14) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 12 && 6 <= j && j <= 17) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 6 && 4 <= j && j <= 16) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 24 && 21 <= j && j <= 31) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 18 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 12 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 6 && 21 <= j && j <= 35) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 24 && 38 <= j && j <= 49) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 12 && 38 <= j && j <= 39) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }
        if (i == 6 && 38 <= j && j <= 50) {
          drawBorderLine(canvas, borderPaint, j * cellWidth, i * cellHeight,
              (j + 1) * cellWidth, i * cellHeight);
        }

        //borda direita

        if (j == 59) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 53 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 52 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 52 && i <= 19 && i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 52 && i <= 13 && i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 52 && i <= 7 && i >= 4) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 1 && i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 19 && i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 13 && i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 7 && i >= 4) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 1 && i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 1 && i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 19 && i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 13 && i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 16 && i <= 7 && i >= 4) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 1 && i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 51 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 49 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 47 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 44 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 41 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 38 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 35 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 32 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 30 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 23 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 20 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 17 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 14 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 11 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 7 && i <= 29 && i >= 28) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 50 && i <= 1 && i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 49 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 31 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 5 && i <= 25 && i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 14 && i <= 19 && i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 5 && i <= 19 && i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 39 && i <= 13 && i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 5 && i <= 13 && i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 50 && i <= 7 && i >= 4) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if ((j == 46 ||
                j == 43 ||
                j == 40 ||
                j == 29 ||
                j == 26 ||
                j == 23 ||
                j == 15 ||
                j == 12 ||
                j == 9) &&
            i <= 25 &&
            i >= 22) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if ((j == 23 ||
                j == 26 ||
                j == 28 ||
                j == 30 ||
                j == 32 ||
                j == 11 ||
                j == 8) &&
            i <= 19 &&
            i >= 16) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if ((j == 32 ||
                j == 29 ||
                j == 23 ||
                j == 27 ||
                j == 14 ||
                j == 11 ||
                j == 8) &&
            i <= 13 &&
            i >= 10) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if (j == 25 && i <= 13 && i >= 12) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if ((j == 47 ||
                j == 44 ||
                j == 41 ||
                j == 32 ||
                j == 29 ||
                j == 26 ||
                j == 23 ||
                j == 13 ||
                j == 10 ||
                j == 7) &&
            i <= 7 &&
            i >= 4) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }
        if ((j == 47 ||
                j == 44 ||
                j == 41 ||
                j == 32 ||
                j == 29 ||
                j == 26 ||
                j == 23 ||
                j == 14 ||
                j == 11 ||
                j == 8 ||
                j == 5) &&
            i <= 1 &&
            i >= 0) {
          drawBorderLine(canvas, borderPaint, (j + 1) * cellWidth,
              i * cellHeight, (j + 1) * cellWidth, (i + 1) * cellHeight);
        }

        // borda esquerda
        if (j == 0) {
          canvas.drawLine(
            Offset(j * cellWidth, i * cellHeight),
            Offset(j * cellWidth, (i + 1) * cellHeight),
            borderPaint,
          );
        }
        if ((j == 3) &&
            ((i <= 29 && i >= 28) ||
                (i <= 25 && i >= 22) ||
                (i <= 19 && i >= 16) ||
                (i <= 13 && i >= 10) ||
                (i <= 1 && i >= 0))) {
          canvas.drawLine(
            Offset(j * cellWidth, i * cellHeight),
            Offset(j * cellWidth, (i + 1) * cellHeight),
            borderPaint,
          );
        }
        if ((j == 21) &&
            ((i <= 25 && i >= 22) ||
                (i <= 19 && i >= 16) ||
                (i <= 13 && i >= 10) ||
                (i <= 7 && i >= 4) ||
                (i <= 1 && i >= 0))) {
          canvas.drawLine(
            Offset(j * cellWidth, i * cellHeight),
            Offset(j * cellWidth, (i + 1) * cellHeight),
            borderPaint,
          );
        }
        if ((j == 38) &&
            ((i <= 25 && i >= 22) ||
                (i <= 19 && i >= 16) ||
                (i <= 13 && i >= 10) ||
                (i <= 7 && i >= 4) ||
                (i <= 1 && i >= 0))) {
          canvas.drawLine(
            Offset(j * cellWidth, i * cellHeight),
            Offset(j * cellWidth, (i + 1) * cellHeight),
            borderPaint,
          );
        }
        if (j == 4 && i <= 7 && i >=4) {
          canvas.drawLine(
            Offset(j * cellWidth, i * cellHeight),
            Offset(j * cellWidth, (i + 1) * cellHeight),
            borderPaint,
          );
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

  return []; // Retorna uma lista vazia se não encontrar um caminho
}

List<Pontos> reconstruirRota(Map<Pontos, Pontos> cameFrom, Pontos current) {
  final List<Pontos> totalPath = [current];
  while (cameFrom.containsKey(current)) {
    current = cameFrom[current]!;
    totalPath.add(current);
  }
  return totalPath.reversed.toList();
}