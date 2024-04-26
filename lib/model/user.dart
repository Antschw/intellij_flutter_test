import 'package:uuid/uuid.dart';

class User {
  final String _id;
  String _nom;
  String _prenom;

  User(this._prenom, this._nom) : _id = const Uuid().v1();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.prenom == prenom &&
        other.nom == nom;
  }

  @override
  int get hashCode => _id.hashCode ^ _prenom.hashCode ^ _nom.hashCode;

  String get id => _id;
  String get nom => _nom;
  String get prenom => _prenom;

  set nom(String value) {
    if (value.isNotEmpty) {
      _nom = value;
    }
  }

  set prenom(String value) {
    if (value.isNotEmpty) {
      _prenom = value;
    }
  }
}