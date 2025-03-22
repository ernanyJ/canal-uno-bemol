import 'package:canaluno/presentation/pages/login/login_state.dart';
import 'package:canaluno/util/config/router.dart';
import 'package:canaluno/util/deserialize_jwt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize the Flutter bindings before using any platform services
  WidgetsFlutterBinding.ensureInitialized();

  // Now it's safe to use FlutterSecureStorage
  final token = await FlutterSecureStorage().read(key: 'acess_token');
  if (token != null) {
    globalToken = token;
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginState()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
            colorScheme: ColorScheme(
          primary: Color.fromRGBO(0, 149, 214, 1),
          secondary: const Color(0xFF00A3FF),
          surface: const Color(0xFFFFFFFF),
          error: const Color(0xFFB00020),
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF000000),
          onError: const Color(0xFFFFFFFF),
          brightness: Brightness.light,
        )),
        routerConfig: MyRouter.router,
        title: 'Canal Uno',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
