import 'package:cep_consult/model/i_model.dart';

class CepModel implements Model {
  @override
  CepModel fromJson(Map<String, dynamic> json) {
    return CepModel();
  }

  String? _id;
  String? _cep;
  String? _logradouro;
  String? _complemento;
  String? _bairro;
  String? _localidade;
  String? _uf;

  CepModel(
      {String? cep,
      String? logradouro,
      String? complemento,
      String? bairro,
      String? localidade,
      String? uf}) {
    if (cep != null) {
      _cep = cep;
    }
    if (logradouro != null) {
      _logradouro = logradouro;
    }
    if (complemento != null) {
      _complemento = complemento;
    }
    if (bairro != null) {
      _bairro = bairro;
    }
    if (localidade != null) {
      _localidade = localidade;
    }
    if (uf != null) {
      _uf = uf;
    }
  }

  String? get id => _id;
  String? get cep => _cep;
  set cep(String? cep) => _cep = cep;
  String? get logradouro => _logradouro;
  set logradouro(String? logradouro) => _logradouro = logradouro;
  String? get complemento => _complemento;
  set complemento(String? complemento) => _complemento = complemento;
  String? get bairro => _bairro;
  set bairro(String? bairro) => _bairro = bairro;
  String? get localidade => _localidade;
  set localidade(String? localidade) => _localidade = localidade;
  String? get uf => _uf;
  set uf(String? uf) => _uf = uf;

  CepModel.fromJson(Map<String, dynamic> json) {
    _id = json.containsKey('objectId') ? json['objectId'] : "";
    _cep = json['cep'];
    _logradouro = json['logradouro'];
    _complemento = json['complemento'];
    _bairro = json['bairro'];
    _localidade = json['localidade'];
    _uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logradouro'] = _logradouro;
    // data['complemento'] = _complemento;
    data['bairro'] = _bairro;
    data['uf'] = _uf;
    data['cep'] = _cep!.replaceAll('-', '');
    data['localidade'] = _localidade;
    return data;
  }
}
