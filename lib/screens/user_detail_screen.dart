import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  UserDetailScreen({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name: $firstName',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Last Name: $lastName',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   final Shader linearGradient = const LinearGradient(
  //     colors: <Color>[Colors.purple, Colors.blue],
  //   ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  //
  //   // print(widget.user.id);
  //   for (var message in _messageController.messages) {
  //     print(message.auteur.id);
  //   }
  //
  //   final userMessages = _messageController.messages.where((message) => message.auteur.id == widget.user.id).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           // '${widget.user.prenom} ${widget.user.nom}',
//           // style: const TextStyle(color: Colors.white),
//         // ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Center(
//               child: Text(
//                 widget.user.prenom,
//                 style: GoogleFonts.lato(
//                   fontSize: 50,
//                   foreground: Paint()..shader = linearGradient,
//                 ),
//               ),
//             ),
//             Center(
//               child: Text(
//                 widget.user.nom,
//                 style: GoogleFonts.lato(
//                   fontSize: 50,
//                   foreground: Paint()..shader = linearGradient,
//                 ),
//               ),
//             ),
//             ...userMessages.map((message) => Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Sujet: ${message.sujet}\nContenu: ${message.contenu}\nDate d\'envoi: ${message.dateEnvoi}\nAuteur: ${message.auteur.prenom} ${message.auteur.nom}',
//                   style: const TextStyle(fontSize: 20),
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }