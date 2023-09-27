import 'dart:math';

class GeradorNumeroAleatorioService {
  static int geraNumeroAleatorio(int numeroMaximo) {
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(numeroMaximo);
  }

}