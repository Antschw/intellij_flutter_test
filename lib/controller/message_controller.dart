import 'package:intellij_flutter_test/model/message.dart';
import 'package:intellij_flutter_test/model/user.dart';
import 'package:intellij_flutter_test/controller/user_controller.dart';

class MessageController {
  final List<Message> _messages = [];
  late UserController _userController;

  MessageController();

  List<Message> get messages => _messages;
  List<User> get users => _userController.users;

  void setUserController(UserController userController) {
    _userController = userController;
  }

  Future<void> loadMessages() async {
    User jeanDupont = _userController.users.firstWhere((user) => user.prenom == 'Jean' && user.nom == 'Dupont');
    User pierreDurand = _userController.users.firstWhere((user) => user.prenom == 'Pierre' && user.nom == 'Durand');

    print('Loading messages...');
    if (users.isNotEmpty) {
      messages.add(Message(
        'Sujet 1',
        'Contenu du message 1',
        DateTime.now(),
        jeanDupont,
      ));

      messages.add(Message(
        'Sujet 2',
        'Contenu du message 2',
        DateTime.now(),
        pierreDurand,
      ));
      print('Messages loaded.');
    } else {
      print('No users found.');
    }
  }
}