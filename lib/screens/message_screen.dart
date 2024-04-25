import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    final message = args ?? 'No message provided';
    return Scaffold(
        appBar: AppBar(
          title: const Text('Message', style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: Text(message),
        ));
  }
}
