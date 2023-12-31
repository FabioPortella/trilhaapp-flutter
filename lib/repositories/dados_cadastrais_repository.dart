import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';

class DadosCadastraisRepositoty {
  static late Box _box;

  DadosCadastraisRepositoty._criar();

  static Future<DadosCadastraisRepositoty> carregar() async {
    if (Hive.isBoxOpen("dadosCadastraisModel")) {
      _box = Hive.box("dadosCadastraisModel");
    } else {
      _box = await Hive.openBox("dadosCadastraisModel");
    }
    return DadosCadastraisRepositoty._criar();
  }

  salvar(DadosCadastraisModel dadosCadastraisModel) {
    _box.put("dadosCadastraisModel", dadosCadastraisModel);
  }

  DadosCadastraisModel obterDados() {
    var dadosCadastraisModel = _box.get("dadosCadastraisModel");
    if (dadosCadastraisModel == null) {
      return DadosCadastraisModel.vazio();
    }
    return dadosCadastraisModel;
  }
}
