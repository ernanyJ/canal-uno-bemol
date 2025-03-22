import 'package:canaluno/data/models/user_model.dart';

class LoginResponse {
  String? token;
  UserModel? username;

  LoginResponse({this.token, this.username});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'] != null ? new UserModel.fromJson(json['username']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.username != null) {
      data['username'] = this.username!.toJson();
    }
    return data;
  }
}
