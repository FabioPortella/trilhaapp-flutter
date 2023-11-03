// ignore_for_file: unnecessary_getters_setters

class ConfiguracoesModel {
  String _nomeUsuario = "";
  double _altura = 0;
  bool _receberNofificacoes = false;
  bool _temaEscuro = false;

  ConfiguracoesModel.vazio() {
    _nomeUsuario = "";
    _altura = 0;
    _receberNofificacoes = false;
    _temaEscuro = false;
  }

  ConfiguracoesModel(this._nomeUsuario, this._altura, this._receberNofificacoes,
      this._temaEscuro);

  String get nomeUsuario => _nomeUsuario;

  set nomeUsuario(String valor) {
    _nomeUsuario = valor;
  }

  double get altura => _altura;

  set altura(double valor) {
    _altura = valor;
  }

  bool get receberNotificacoes => _receberNofificacoes;

  set receberNotificacoes(bool valor) {
    _receberNofificacoes = valor;
  }

  bool get temaEscuro => _temaEscuro;

  set temaEscuro(bool valor) {
    _temaEscuro = valor;
  }
}
