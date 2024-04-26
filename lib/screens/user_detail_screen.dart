import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellij_flutter_test/controller/user_controller.dart';
import 'package:intellij_flutter_test/model/user.dart';
import 'package:intellij_flutter_test/controller/message_controller.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;
  final UserController userController;

  const UserDetailScreen({required this.user, required this.userController});

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late UserController _userController;
  late MessageController _messageController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userController;
    _messageController = MessageController();
    _messageController.setUserController(_userController);
    _userController.loadUsers().then((_) {
      print('Users loaded.');
      _messageController.loadMessages().then((_) {
        print('Messages loaded.');
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Colors.purple, Colors.blue],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    print('${widget.user.id}');
    _messageController.messages.forEach((message) {
      print('${message.auteur.id}');
    });

    final userMessages = _messageController.messages.where((message) => message.auteur.id == widget.user.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.user.prenom} ${widget.user.nom}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                widget.user.prenom,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.user.nom,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            ...userMessages.map((message) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sujet: ${message.sujet}\nContenu: ${message.contenu}\nDate d\'envoi: ${message.dateEnvoi}\nAuteur: ${message.auteur.prenom} ${message.auteur.nom}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}