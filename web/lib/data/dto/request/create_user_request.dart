import 'package:canaluno/data/dto/request/address_request.dart';
import 'package:canaluno/data/enums/user_role.dart';

class CreateUserRequest {
  final String name;
  final String login;
  final String email;
  final String password;
  final UserRole role;
  final AddressRequest address;

  CreateUserRequest({
    required this.name,
    required this.login,
    required this.email,
    required this.password,
    required this.role,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['login'] = login;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role.toString().split('.').last;
    data['address'] = address.toJson();
    return data;
  }
}
