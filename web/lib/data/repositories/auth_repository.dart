import 'package:canaluno/data/dto/request/create_user_request.dart';
import 'package:canaluno/data/dto/response/login_response.dart';
import 'package:canaluno/presentation/pages/auth_provider.dart';
import 'package:canaluno/util/config/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _client = ApiClient().instance;
  final _storage = FlutterSecureStorage();

  Future<LoginResponse> login(String user, String password) async {
    final response = await _client.post('/auth/login', data: {
      'login': user,
      'password': password,
    });

    await _storage.write(key: "acess_token", value: response.data['token']);
    if (await _storage.read(key: "acess_token") != null) {
      AuthProvider().setToken(response.data['token']);
    }

    return LoginResponse.fromJson(response.data);
  }

  Future<void> signUp(CreateUserRequest user) async {
    await _client.post('/auth/signup', data: user.toJson());
  }
}
