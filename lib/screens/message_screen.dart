import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/controller/message_controller.dart';
import 'package:intellij_flutter_test/controller/user_controller.dart';
import 'package:intellij_flutter_test/model/message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late UserController _userController;
  late MessageController _messageController;

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    _messageController = MessageController();
    _messageController.setUserController(_userController);
    _userController.loadUsers().then((_) {
      _messageController.loadMessages().then((_) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: _messageController.messages.length,
        itemBuilder: (BuildContext context, int index) {
          Message message = _messageController.messages[index];
          return Card(
            child: ListTile(
              title: Text(message.sujet),
              subtitle: Text('${message.contenu}\nAuteur: ${message.auteur.prenom} ${message.auteur.nom}'),
            ),
          );
        },
      )
    );
  }
}