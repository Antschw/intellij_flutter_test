import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellij_flutter_test/model/user.dart';
import 'package:intellij_flutter_test/controller/message_controller.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  final MessageController _messageController = MessageController();

  UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Colors.purple, Colors.blue],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    // Filtrer les messages pour obtenir uniquement ceux dont l'utilisateur est l'auteur
    final userMessages = _messageController.messages.where((message) => message.auteur == user).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${user.prenom} ${user.nom}',
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
                user.prenom,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            Center(
              child: Text(
                user.nom,
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