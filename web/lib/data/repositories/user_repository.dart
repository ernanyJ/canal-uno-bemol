import 'package:canaluno/data/models/user_model.dart';
import 'package:canaluno/util/config/api.dart';

class UserRepository {
  final _client = ApiClient().instance;

  Future<List<UserModel>> getAll() async {
    final response = await _client.get('/user');
    return (response.data as List).map((e) => UserModel.fromJson(e)).toList();
  }

  void delete(String id) {
    _client.delete('/user', queryParameters: {'id': id});
  }

  void update(String id, UserModel updatedUser) {
    _client.put('/user', queryParameters: {'id': id}, data: updatedUser.toJson());
  }
}
