import 'package:cep_consult/model/i_model.dart';

abstract class Repository<T extends Model> {
  Future<List<T>> list();
  Future<T?> get(int id);
  Future<void> create(T data);
  Future<void> delete(String id);
  Future<T> update(String objID, Map<String, dynamic> data);
}
