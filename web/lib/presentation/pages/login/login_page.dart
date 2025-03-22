import 'package:canaluno/presentation/pages/login/login_state.dart';
import 'package:canaluno/presentation/pages/login/widgets/sign_in_form_widget.dart.dart';
import 'package:canaluno/presentation/pages/login/widgets/sign_up_form_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:provider/provider.dart'; // Importado para ImageFilter

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginState>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/bemol.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: state.signUp ? 500 : 400),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: state.signUp ? SignUpFormWidget() : SignInFormWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
