import 'package:canaluno/presentation/pages/login/login_state.dart';
import 'package:canaluno/util/deserialize_jwt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  final _storage = FlutterSecureStorage();

  String? get token => _token;

  void setToken(String token) async {
    _token = token;
    globalToken = token;
    await _storage.write(key: 'acess_token', value: token);
    notifyListeners();
  }

  void clear() {
    globalToken = '';
    _token = null;
    _storage.delete(key: 'acess_token');
  }

  void logout(BuildContext context) {
    // clear login state
    context.read<LoginState>().clear();
    clear();
    context.go('/login');
  }
}
