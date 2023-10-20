import 'package:cep_consult/http/back_4_app_http.dart';
import 'package:cep_consult/http/viacep_api_http.dart';
import 'package:cep_consult/model/cep_model.dart';
import 'package:cep_consult/repository/i_repository.dart';

class CepRepository implements Repository<CepModel> {
  var back4AppHttp = Back4AppHttp();
  var viacepApphttp = ViaCepAppHttp();

  @override
  Future<void> create(CepModel data) async {
    try {
      await back4AppHttp.dio.post('classes/cep', data: data.toJson());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> delete(String id) async {
    await back4AppHttp.dio.delete('classes/cep/$id');
  }

  @override
  Future<CepModel?> get(int cep) async {
    try {
      var response =
          await back4AppHttp.dio.get('classes/cep?where={"cep":"$cep"}');
      print(response.data['results']);
      if ((response.data['results'] as List<dynamic>).isEmpty) {
        var viaCepResponse = await viacepApphttp.dio.get('$cep/json/');

        if (viaCepResponse.statusCode == 200) {
          var modelCep = CepModel.fromJson(viaCepResponse.data);
          await create(modelCep);
          return modelCep;
        } else {
          var modelCep = CepModel.fromJson(response.data['results'][0]);
          return modelCep;
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Future<List<CepModel>> list() async {
    var resList = await back4AppHttp.dio.get('classes/cep');
    if (resList.statusCode == 200) {
      List<CepModel> modelList = [];

      (resList.data['results'] as List<dynamic>).forEach((element) {
        modelList.add(CepModel.fromJson(element));
      });

      return modelList;
    }

    return [];
  }

  @override
  Future<CepModel> update(String objID, Map<String, dynamic> data) async {
    var response = await back4AppHttp.dio.put('classes/cep/$objID', data: data);
    print(response);

    return CepModel();
  }
}
