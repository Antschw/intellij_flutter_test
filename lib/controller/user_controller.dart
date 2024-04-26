import 'package:intellij_flutter_test/model/user.dart';

class UserController {
  final List<User> _users = [];
  List<User> get users => _users;
  Future<void> loadUsers() async {
    users.add(User('Dupont', 'Jean'));
    users.add(User('Durand', 'Pierre'));
    users.add(User('Martin', 'Paul'));
    users.add(User('Leclerc', 'Marie'));
    users.add(User('Bertrand', 'Luc'));
    users.add(User('Dupont', 'Pierre'));
    users.add(User('Durand', 'Baptiste'));
    users.add(User('Martin', 'Jérôme'));
    users.add(User('Leclerc', 'Hélène'));
    users.add(User('Bertrand', 'Karine'));
    users.add(User('Dupont', 'Peter'));
    users.add(User('Durand', 'David'));
    users.add(User('Martin', 'Lucas'));
    users.add(User('Leclerc', 'Valérie'));
    users.add(User('Bertrand', 'Eva'));
  }
}