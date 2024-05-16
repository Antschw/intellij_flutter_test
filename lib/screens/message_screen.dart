import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/api/message.dart';
import 'package:intellij_flutter_test/model/message_model.dart';
import 'package:intellij_flutter_test/widgets/myscaffold.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<MessageModel>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = Message().fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      name: 'Message',
      body: FutureBuilder<List<MessageModel>>(
        future: futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun message trouvé.'));
          } else {
            List<MessageModel> messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                MessageModel message = messages[index];
                return ListTile(
                  title: Text(message.subject),
                  subtitle: Text(message.body),
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
