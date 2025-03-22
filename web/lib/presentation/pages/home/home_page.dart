import 'package:canaluno/data/models/user_model.dart';
import 'package:canaluno/presentation/pages/auth_provider.dart';
import 'package:canaluno/presentation/pages/home/state/home_state.dart';
import 'package:canaluno/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.loggedUser});
  final UserModel? loggedUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeState _homeState;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: Builder(
        builder: (BuildContext providerContext) {
          _homeState = Provider.of<HomeState>(providerContext, listen: false);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _homeState.init();
          });

          return Consumer<HomeState>(
            builder: (context, state, _) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Row(
                        spacing: 5,
                        children: [
                          const Text('Sair'),
                          const Icon(Icons.exit_to_app),
                        ],
                      ),
                      onPressed: () => AuthProvider().logout(context),
                    ),
                  ],
                ),
                body: Center(
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: MyButton(
                          label: 'Atualizar lista',
                          onPressed: () => state.init(),
                        ),
                      ),
                      DataTable(
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
                        columns: const [
                          DataColumn(label: Text('Nome')),
                          DataColumn(label: Text('Login')),
                          DataColumn(label: Text('E-mail')),
                          DataColumn(label: Text('Role')),
                          DataColumn(label: Text('Ações')),
                        ],
                        rows: state.users
                            .map((user) => DataRow(cells: [
                                  DataCell(Text(user.name)),
                                  DataCell(Text(user.login)),
                                  DataCell(Text(user.email)),
                                  DataCell(Text(user.role)),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => state.editUser(user, context),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => state.deleteUser(user, context),
                                      ),
                                    ],
                                  )),
                                ]))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
