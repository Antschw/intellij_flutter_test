import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

enum Character { homme, femme, autre }

class _SettingsScreenState extends State<SettingsScreen> {
  // Initialisation des variables
  double sliderValue = 25.0;
  Character? _character = Character.autre;
  bool _isTermsAccepted = false;
  DateTime _selectedDate = DateTime.now();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  /// Fonction de validation du formulaire
  ///
  /// Vérifie que les champs sont remplis correctement
  ///
  /// Et affiche une boîte de dialogue en cas d'erreur
  void _validateForm() {
    String? error;
    if (_firstNameController.text.isEmpty) {
      error = 'Le prénom ne peut pas être vide';
    } else if (_lastNameController.text.isEmpty) {
      error = 'Le nom ne peut pas être vide';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(_firstNameController.text)) {
      error = 'Le prénom ne peut pas contenir de caractères spéciaux';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(_lastNameController.text)) {
      error = 'Le nom ne peut pas contenir de caractères spéciaux';
    } else if (_selectedDate.day != DateTime.now().day ||
        _selectedDate.month != DateTime.now().month ||
        _selectedDate.year != DateTime.now().year) {
      error = 'La date sélectionnée doit être la date du jour';
    } else if (!_isTermsAccepted) {
      error = 'Vous devez accepter les conditions d\'utilisation';
    }

    if (error != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: Text(error!),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        _firstNameController.clear();
        _lastNameController.clear();
        _isTermsAccepted = false;
        _selectedDate = DateTime.now();
        _character = Character.autre;
        sliderValue = 25.0;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Succès'),
            content: const Text('Formulaire valide'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  /// Fonction de sélection de la date
  ///
  /// Ouvre un calendrier pour sélectionner une date
  ///
  /// Met à jour la date sélectionnée
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Fonction de construction de l'interface
  ///
  /// Liste les différents champs du formulaire
  ///
  /// Et se termine par un bouton de validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
      ),
      // Corps de la page
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.white,
        child: Center(
          // Liste des champs du formulaire organisés en colonne
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Padding(
                padding: const EdgeInsets.all(15.0),
                // Champ de texte pour le prénom avec décoration
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                // Champ de texte pour le nom avec décoration
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
                    ),
                  ),
                ),
              ),
              Text(
                'Age : ${sliderValue.round()}',
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                // Curseur pour l'âge
                child: Slider(
                  value: sliderValue,
                  min: 18,
                  max: 40,
                  divisions: 22,
                  label: sliderValue.round().toString(),
                  activeColor: Colors.indigo,
                  inactiveColor: Colors.indigo.withOpacity(0.2),
                  onChanged: (double newValue) {
                    setState(() {
                      sliderValue = newValue;
                    });
                  },
                ),
              ),
              // Liste des boutons radio pour le genre
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Vous êtes : ',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<Character>(
                    title: const Text(
                      'Homme',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    activeColor: Colors.indigo,
                    value: Character.homme,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  RadioListTile<Character>(
                    title: const Text(
                      'Femme',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    activeColor: Colors.indigo,
                    value: Character.femme,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  RadioListTile<Character>(
                    title: const Text(
                      'Autre',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    activeColor: Colors.indigo,
                    value: Character.autre,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ],
              ),
              // Bouton pour sélectionner la date
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Capchat : Sélectionner la date du jour : ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
              ),
              // ...
              // Checkbox pour accepter les conditions d'utilisation
              CheckboxListTile(
                title: const Text(
                  'J\'accepte les Conditions Générales d\'utilisation',
                  style: TextStyle(fontSize: 14.0),
                ),
                value: _isTermsAccepted,
                onChanged: (bool? value) {
                  setState(() {
                    _isTermsAccepted = value ?? false;
                  });
                },
              ),
              // Bouton de validation du formulaire
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                ),
                onPressed: _validateForm,
                child: const Text(
                  'Valider le formulaire',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


