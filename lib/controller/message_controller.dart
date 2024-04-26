import 'package:intellij_flutter_test/model/message.dart';
import 'package:intellij_flutter_test/model/user.dart';

class MessageController {
  final List<Message> _messages = [];
  final List<User> _users = [];
  List<Message> get messages => _messages;
  List<User> get users => _users;

  Future<void> loadMessages() async {
    if (users.isNotEmpty) {
      messages.add(Message(
        'Sujet 1',
        'Contenu du message 1',
        DateTime.now(),
        users[0],
      ));

      messages.add(Message(
        'Sujet 2',
        'Contenu du message 2',
        DateTime.now(),
        users[1],
      ));
    }
  }
}