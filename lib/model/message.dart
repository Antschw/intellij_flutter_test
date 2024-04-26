import 'package:intellij_flutter_test/model/user.dart';

class Message {
  String _sujet;
  String _contenu;
  DateTime _dateEnvoi;
  User _auteur;

  Message(
    this._sujet,
    this._contenu,
    this._dateEnvoi,
    this._auteur,
  );

  String get sujet => _sujet;

  String get contenu => _contenu;

  DateTime get dateEnvoi => _dateEnvoi;

  User get auteur => _auteur;

  set sujet(String value) {
    if (value.isNotEmpty) {
      _sujet = value;
    }
  }

  set contenu(String value) {
    if (value.isNotEmpty) {
      _contenu = value;
    }
  }

  set dateEnvoi(DateTime value) {
    _dateEnvoi = value;
  }

  set auteur(User value) {
    _auteur = value;
  }

  @override
  String toString() {
    return 'Message{sujet: $_sujet, contenu: $_contenu, dateEnvoi: $_dateEnvoi, auteur: $_auteur}';
  }
}
