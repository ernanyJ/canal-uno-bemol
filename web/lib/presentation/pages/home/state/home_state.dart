import 'package:canaluno/data/models/address_model.dart';
import 'package:canaluno/data/models/user_model.dart';
import 'package:canaluno/data/repositories/user_repository.dart';
import 'package:canaluno/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<UserModel> users = [];
  final UserRepository _userRepository = UserRepository();

  /// Initializes the state by fetching all users from the repository.
  Future<void> init() async {
    _toggleLoading();
    users = await _userRepository.getAll();
    _toggleLoading();
  }

  /// Toggles the loading state and notifies listeners.
  void _toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  /// Opens a dialog to edit a user's details and updates the user upon confirmation.
  void editUser(UserModel user, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        final nameController = TextEditingController(text: user.name);
        final loginController = TextEditingController(text: user.login);
        final emailController = TextEditingController(text: user.email);
        final roleController = TextEditingController(text: user.role);
        final streetController = TextEditingController(text: user.address?.street ?? '');
        final neighborhoodController = TextEditingController(text: user.address?.neighborhood ?? '');
        final cityController = TextEditingController(text: user.address?.city ?? '');
        final stateController = TextEditingController(text: user.address?.state ?? '');
        final zipCodeController = TextEditingController(text: user.address?.zipCode ?? '');

        return SimpleDialog(contentPadding: EdgeInsets.all(36), title: const Text('Editar Usuário'), children: [
          UpdateUserDialog(
            nameController: nameController,
            loginController: loginController,
            emailController: emailController,
            roleController: roleController,
            streetController: streetController,
            neighborhoodController: neighborhoodController,
            cityController: cityController,
            stateController: stateController,
            zipCodeController: zipCodeController,
          ),
          MyButtonSecondary(
            onPressed: () => Navigator.of(dialogContext).pop(),
            label: 'Cancelar',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MyButton(
              onPressed: () async {
                // Update user properties with new values
                final updatedUser = user.copyWith(
                    name: nameController.text,
                    login: loginController.text,
                    email: emailController.text,
                    role: roleController.text,
                    address: AddressModel(
                      id: user.address.id,
                      street: streetController.text,
                      neighborhood: neighborhoodController.text,
                      city: cityController.text,
                      state: stateController.text,
                      zipCode: zipCodeController.text,
                    ));

                // Update the user in the repository
                _userRepository.update(user.id, updatedUser);
                notifyListeners(); // Notify UI of the change
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Usuário atualizado com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              label: 'Salvar',
            ),
          ),
        ]);
      },
    );
  }

  /// Opens a confirmation dialog to delete a user and removes the user upon confirmation.
  void deleteUser(UserModel user, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza de que deseja excluir este usuário?'),
          actions: [
            MyButtonSecondary(
              onPressed: () => Navigator.of(dialogContext).pop(),
              label: 'Cancelar',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MyButton(
                onPressed: () async {
                  // Delete the user from the repository
                  _userRepository.delete(user.id);
                  users.remove(user); // Remove user from local list
                  notifyListeners(); // Notify UI of the change
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Usuário deletado com sucesso!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                label: 'Excluir',
              ),
            ),
          ],
        );
      },
    );
  }
}

class UpdateUserDialog extends StatelessWidget {
  const UpdateUserDialog({
    super.key,
    required this.nameController,
    required this.loginController,
    required this.emailController,
    required this.roleController,
    required this.streetController,
    required this.neighborhoodController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
  });

  final TextEditingController nameController;
  final TextEditingController loginController;
  final TextEditingController emailController;
  final TextEditingController roleController;
  final TextEditingController streetController;
  final TextEditingController neighborhoodController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Dados pessoais', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            DropdownButtonFormField<String>(
              value: roleController.text.isNotEmpty ? roleController.text : null,
              decoration: const InputDecoration(labelText: 'Função'),
              items: const [
                DropdownMenuItem(value: 'CUSTOMER', child: Text('CUSTOMER')), // Fixed spelling
                DropdownMenuItem(value: 'AGENT', child: Text('AGENT')),
              ],
              onChanged: (value) {
                if (value != null) {
                  roleController.text = value;
                }
              },
            ),
            SizedBox(height: 12),
            Text('Endereço', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            TextField(
              controller: streetController,
              decoration: const InputDecoration(labelText: 'Rua'),
            ),
            TextField(
              controller: neighborhoodController,
              decoration: const InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: stateController,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            TextField(
              controller: zipCodeController,
              decoration: const InputDecoration(labelText: 'CEP'),
            ),
          ],
        ),
      ),
    );
  }
}
