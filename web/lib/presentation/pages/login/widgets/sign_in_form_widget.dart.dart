import 'package:canaluno/presentation/pages/login/login_state.dart';
import 'package:canaluno/presentation/widgets/my_button.dart';
import 'package:canaluno/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginState>();
    return Form(
      key: state.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Canal Uno',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          MyField(
            validator: (p0) => state.validator(p0),
            icon: const Icon(Icons.person, color: Colors.grey),
            hint: 'Login',
            inputController: state.userControllersSignIn,
          ),
          const SizedBox(height: 10),
          MyField(
            validator: (p0) => state.validator(p0),
            icon: const Icon(Icons.lock, color: Colors.grey),
            hint: 'Senha',
            obscureText: true,
            inputController: state.passwordControllerSignIn,
          ),
          const SizedBox(height: 20),
          MyButton(
            label: 'Entrar',
            isLoading: state.isLoading,
            onPressed: () => state.performLogin(context),
          ),
          SizedBox(height: 12),
          MyButtonSecondary(
            label: 'Criar conta',
            onPressed: () => state.signUp = true,
          ),
        ],
      ),
    );
  }
}
