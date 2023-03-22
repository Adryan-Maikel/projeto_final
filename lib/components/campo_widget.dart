import 'package:flutter/material.dart';
import '../model/campo.dart';

class CampoWidget extends StatelessWidget {

  final Campo campo;
  final void Function(Campo) onAbrir;
  final void Function(Campo) onAlternarMarcacao;

  const CampoWidget({
    super.key, 
    required this.campo,
    required this.onAbrir,
    required this.onAlternarMarcacao,
  });

  Widget _getImage() {
    int qntDeMinas = campo.quantidadeMinasNaVizinhanca;
    if(campo.aberto && campo.minado && campo.explodido) {
      return Image.asset('assets/bomba_explidia.jpeg');
    } else if(campo.aberto && campo.minado) {
      return Image.asset('assets/bomba.jpeg');
    } else if(campo.aberto && qntDeMinas > 0) {
      return Image.asset('assets/aberto_$qntDeMinas.jpeg');
    } else if(campo.aberto) {
      return Image.asset('assets/aberto_0.jpeg');
    } else if(campo.marcado) {
      return Image.asset('assets/bandeira.jpeg');
    } else {
      return Image.asset('assets/fechado.jpeg');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(campo),
      onLongPress: () => onAlternarMarcacao(campo),
      child: _getImage(),
    );
  }
}