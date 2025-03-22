import 'package:canaluno/data/dto/request/address_request.dart';
import 'package:canaluno/data/dto/request/create_user_request.dart';
import 'package:canaluno/data/dto/response/address_complete_response.dart';
import 'package:canaluno/data/enums/user_role.dart';
import 'package:canaluno/data/models/user_model.dart';
import 'package:canaluno/data/repositories/auth_repository.dart';
import 'package:canaluno/data/repositories/address_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class LoginState extends ChangeNotifier {
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  get formKey => _formKey;

  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  get signUpKey => _signUpKey;

  bool _signUp = false;
  bool get signUp => _signUp;
  set signUp(bool value) {
    _signUp = value;
    notifyListeners();
  }

  UserModel? user;

  final userControllersSignIn = TextEditingController();
  final passwordControllerSignIn = TextEditingController();

  void _toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  final String _message = 'Campo obrigatório!';

  final nameControllersSignUp = TextEditingController();

  final loginControllersSignUp = TextEditingController();

  final emailControllerSignUp = TextEditingController();

  final passwordControllerSignUp = TextEditingController();

  TextEditingController cepControllerSignUp = TextEditingController();

  TextEditingController cityControllerSignUp = TextEditingController();

  TextEditingController stateControllerSignUp = TextEditingController();

  TextEditingController streetControllerSignUp = TextEditingController();

  TextEditingController numberControllerSignUp = TextEditingController();

  TextEditingController neighborhoodControllerSignUp = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return _message;
    }
    return null;
  }

  void performRegister() async {
    if (_signUpKey.currentState!.validate()) {
      _toggleLoading();

      final AuthRepository repository = AuthRepository();
      final user = _mountUserReq();

      await repository.signUp(user);

      userControllersSignIn.text = user.login;
      passwordControllerSignIn.text = user.password;

      _signUp = false;
      _toggleLoading();
    }
  }

  Future<bool> performLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _toggleLoading();
      try {
        final AuthRepository repository = AuthRepository();
        final login = await repository.login(userControllersSignIn.text, passwordControllerSignIn.text);

        user = login.username;

        if (user != null) {
          _toggleLoading();
          context.go('/home', extra: user);
          FlutterSecureStorage().write(key: 'user', value: user!.toJson().toString());
          return true;
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Erro ao realizar login: $e'),
        ));
      }
    }
    _toggleLoading();

    return false;
  }

  void performAutoComplete(String p0, BuildContext context) async {
    if (p0.length < 10) return;

    final AddressRepository repository = AddressRepository();

    try {
      AddressCompleteResponse response = await repository.validateCep(p0);

      cityControllerSignUp.text = response.city ?? '';
      stateControllerSignUp.text = response.state ?? '';
      streetControllerSignUp.text = response.street ?? '';
      neighborhoodControllerSignUp.text = response.neighborhood ?? '';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text('CEP validado com sucesso!'),
      ));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Erro ao validar CEP: $e'),
        ));
      }
    }
  }

  void clear() {
    userControllersSignIn.clear();
    passwordControllerSignIn.clear();
    nameControllersSignUp.clear();
    loginControllersSignUp.clear();
    emailControllerSignUp.clear();
    passwordControllerSignUp.clear();
    cepControllerSignUp.clear();
    cityControllerSignUp.clear();
    stateControllerSignUp.clear();
    streetControllerSignUp.clear();
    numberControllerSignUp.clear();
    neighborhoodControllerSignUp.clear();
  }

  CreateUserRequest _mountUserReq() {
    return CreateUserRequest(
      name: nameControllersSignUp.text,
      login: loginControllersSignUp.text,
      email: emailControllerSignUp.text,
      password: passwordControllerSignUp.text,
      role: UserRole.CUSTOMER,
      address: AddressRequest(
        zipCode: cepControllerSignUp.text,
        complement: '',
        city: cityControllerSignUp.text,
        state: stateControllerSignUp.text,
        street: streetControllerSignUp.text,
        number: numberControllerSignUp.text,
        neighborhood: neighborhoodControllerSignUp.text,
      ),
    );
  }
}
