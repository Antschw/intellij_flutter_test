import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/controller/user_controller.dart';
import 'package:intellij_flutter_test/model/user.dart';


class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  _UsersListScreen createState() {
    return _UsersListScreen();
  }
}

class _UsersListScreen extends State<UsersListScreen> {
  UserController _userController = UserController();
  @override
  void initState() {
    super.initState();
    _userController.loadUsers();
  }
  Widget _buildUserList() {
    return ListView.builder(
      itemCount: _userController.users.length,
      itemBuilder: (BuildContext context, int index) {
        User user = _userController.users[index];
        return ListTile(
          title: Text('${user.prenom} ${user.nom}'),
        );
      },
    );
  }

  void _addUser() {
    _showAddUserDialog().then((user) {
      if (user != null) {
        _userController.users.add(user);
        setState(() {});
      }
    });
  }

  Future<User?> _showAddUserDialog() {
    final formKey = GlobalKey<FormState>();
    String prenom = '';
    String nom = '';

    return showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo.shade50,
          title: const Text('Ajouter un utilisateur', style: TextStyle(color: Colors.black)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un prénom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    prenom = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nom = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter', style: TextStyle(color: Colors.black)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  Navigator.of(context).pop(User(nom, prenom));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List', style: TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: _buildUserList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        backgroundColor: Colors.indigo.shade200,
        child: const Icon(Icons.add),
      ),
    );
  }
}
