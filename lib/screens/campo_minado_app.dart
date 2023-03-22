import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/model/tabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
// import '../model/DAO/winsDAO.dart';
import '../model/campo.dart';
import '../model/explosao_exception.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({super.key});
  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;
  int quantidadeGanhou = 0;

  _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }
    // print('Abrir...');
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro!.resolvido) {
          quantidadeGanhou++;
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro?.revelarBombas();
        quantidadeGanhou = 0;
      }
    });
  }

  _alterarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    // print('Alterar marcacao ${campo.coluna} e ${campo.linha}');
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro!.resolvido) {
        quantidadeGanhou++;
        _venceu = true;
        // WinsDao.insert(quantidadeGanhou as Map<String, dynamic>);
      }
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int quantidadeDeColunas = 15;
      double tamanhoCampo = largura / quantidadeDeColunas;
      int quantidadeDeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: quantidadeDeLinhas,
        colunas: quantidadeDeColunas,
        quantidadeBombas: 1,
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(builder: (context, constraints) {
            return TabuleiroWidget(
              tabuleiro: _getTabuleiro(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              onAbrir: _abrir,
              onAlternarMarcacao: _alterarMarcacao,
            );
          }),
        ),
      ),
    );
  }
}
