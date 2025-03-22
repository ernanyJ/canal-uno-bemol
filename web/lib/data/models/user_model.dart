import 'package:canaluno/data/models/address_model.dart';

class UserModel {
  final String id;
  final String name;
  final String login;
  final String email;
  final String role;
  final AddressModel address;

  UserModel({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.role,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      login: json['login'],
      email: json['email'],
      role: json['role'],
      address: AddressModel.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'email': email,
      'role': role,
      'address': address.toJson(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? login,
    String? email,
    String? role,
    AddressModel? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      login: login ?? this.login,
      email: email ?? this.email,
      role: role ?? this.role,
      address: address ?? this.address,
    );
  }
}
