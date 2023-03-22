import 'dart:math';
import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int quantidadeBombas;
  final List<Campo> _campos = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.quantidadeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    for (var c in _campos) {
      c.reiniciar();
    }
    _sortearMinas();
  }

  void revelarBombas() {
    for (var c in _campos) {
      c.revelarBombas();
    }
  }

  void _criarCampos() {
    for (int linha = 0; linha < linhas; linha++) {
      for (int coluna = 0; coluna < colunas; coluna++) {
        _campos.add(Campo(linha: linha, coluna: coluna));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (quantidadeBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < quantidadeBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((c) => c.resolvido);
  }
}
