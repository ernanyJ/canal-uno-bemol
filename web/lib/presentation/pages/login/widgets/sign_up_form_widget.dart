import 'package:brasil_fields/brasil_fields.dart';
import 'package:canaluno/presentation/pages/login/login_state.dart';
import 'package:canaluno/presentation/widgets/my_button.dart';
import 'package:canaluno/presentation/widgets/my_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginState>();
    return Form(
      key: state.signUpKey,
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Canal Uno',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dados pessoais',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.abc, color: Colors.grey),
                        hint: 'Nome',
                        inputController: state.nameControllersSignUp,
                      ),
                    ),
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        hint: 'Login',
                        icon: const Icon(Icons.person, color: Colors.grey),
                        inputController: state.loginControllersSignUp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            MyField(
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Campo obrigatório!';
                }
                if (!p0.contains('@')) {
                  return 'E-mail inválido!';
                }
                return null;
              },
              icon: const Icon(Icons.email, color: Colors.grey),
              hint: 'E-mail',
              inputController: state.emailControllerSignUp,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
              ],
            ),
            MyField(
              validator: (p0) => state.validator(p0),
              icon: const Icon(Icons.lock, color: Colors.grey),
              hint: 'Senha',
              obscureText: true,
              inputController: state.passwordControllerSignUp,
            ),
            SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Endereço',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.location_on, color: Colors.grey),
                        hint: 'CEP',
                        onChanged: (p0) => state.performAutoComplete(p0, context),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter(),
                        ],
                        inputController: state.cepControllerSignUp,
                      ),
                    ),
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        hint: 'Bairro',
                        icon: const Icon(Icons.format_list_numbered, color: Colors.grey),
                        inputController: state.neighborhoodControllerSignUp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Flexible(
                      flex: 5,
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.location_on, color: Colors.grey),
                        hint: 'Rua',
                        inputController: state.streetControllerSignUp,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.location_on, color: Colors.grey),
                        hint: 'Numero',
                        inputController: state.numberControllerSignUp, // Use a separate controller if needed
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.location_city, color: Colors.grey),
                        hint: 'Cidade',
                        inputController: state.cityControllerSignUp,
                      ),
                    ),
                    Expanded(
                      child: MyField(
                        validator: (p0) => state.validator(p0),
                        icon: const Icon(Icons.location_city, color: Colors.grey),
                        hint: 'Estado',
                        inputController: state.stateControllerSignUp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                MyField(
                  validator: (p0) => state.validator(p0),
                  icon: const Icon(Icons.reduce_capacity, color: Colors.grey),
                  hint: 'Bairro',
                  inputController: state.neighborhoodControllerSignUp,
                ),
              ],
            ),
            MyButton(
              label: 'Cadastrar',
              isLoading: state.isLoading,
              onPressed: () => state.performRegister(),
            ),
            MyButtonSecondary(
              label: 'Voltar',
              onPressed: () => state.signUp = false,
            ),
          ],
        ),
      ),
    );
  }
}
