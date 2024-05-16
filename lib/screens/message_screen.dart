import 'package:flutter/material.dart';
import 'package:intellij_flutter_test/api/message.dart';
import 'package:intellij_flutter_test/api/user.dart';
import 'package:intellij_flutter_test/model/message_model.dart';
import 'package:intellij_flutter_test/model/user.dart';
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No message found'));
          } else {
            List<MessageModel> messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                MessageModel message = messages[index];
                return FutureBuilder<User>(
                  future: fetchUserDetails(message.userId),
                  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      );
                    } else if (snapshot.error != null) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      User user = snapshot.data!;
                      return Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${user.prenom} ${user.nom}'),
                              SizedBox(height: 8.0),  // This is a spacer widget
                              Text('${message.subject}'),
                            ],
                          ),
                          subtitle: Text(message.body),
                          onTap: () {},
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}