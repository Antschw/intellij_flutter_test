import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Colors.purple, Colors.blue],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      appBar: AppBar(
        title: Text('User Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                firstName,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            Center(
              child: Text(
                lastName,
                style: GoogleFonts.lato(
                  fontSize: 50,
                  foreground: Paint()..shader = linearGradient,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                'Email: $email',
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
