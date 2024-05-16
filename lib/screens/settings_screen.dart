import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

enum Sector { public, prive }

class _SettingsScreenState extends State<SettingsScreen> {
  // Initialisation des variables
  double sliderValue = 25.0;
  Sector? _sector = Sector.public;
  bool _isTermsAccepted = false;
  DateTime _selectedDate = DateTime.now();
  String dropdownValue = 'Homme';
  String? firstNameError;
  String? lastNameError;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final player = AudioPlayer();
  Color cardColor = Colors.blue;
  final List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.purple, Colors.orange, Colors.pink, Colors.indigo, Colors.teal, Colors.brown, Colors.grey, Colors.cyan, Colors.lime, Colors.amber, Colors.deepPurple, Colors.lightBlue, Colors.lightGreen, Colors.deepOrange, Colors.blueGrey, Colors.black, Colors.white, Colors.redAccent, Colors.greenAccent, Colors.blueAccent, Colors.yellowAccent, Colors.purpleAccent, Colors.orangeAccent, Colors.pinkAccent, Colors.indigoAccent, Colors.tealAccent, Colors.cyanAccent, Colors.limeAccent, Colors.amberAccent, Colors.deepPurpleAccent, Colors.lightBlueAccent, Colors.lightGreenAccent, Colors.deepOrangeAccent, Colors.blueGrey];
  int colorIndex = 0;

  void changeColor() {
    setState(() {
      colorIndex = (colorIndex + 1) % colors.length;
      cardColor = colors[colorIndex];
    });
  }

  /// Fonction de validation du formulaire
  ///
  /// Vérifie que les champs sont remplis correctement
  ///
  /// Et affiche une boîte de dialogue en cas d'erreur
  void _validateForm() {
    setState(() {
      firstNameError = _firstNameController.text.isEmpty
          ? 'Le prénom ne peut pas être vide'
          : null;
      lastNameError = _lastNameController.text.isEmpty
          ? 'Le nom ne peut pas être vide'
          : null;
    });
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
        _sector = Sector.public;
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
        title: const Text('Formulaire', style: TextStyle(color: Colors.white)),
      ),
      // Corps de la page
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            // Liste des champs du formulaire organisés en colonne
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Prénom',
                      errorText: firstNameError,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: firstNameError == null
                                ? Colors.indigo
                                : Colors.red,
                            width: 2.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      errorText: lastNameError,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: lastNameError == null
                                ? Colors.indigo
                                : Colors.red,
                            width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Age : ${sliderValue.round()}',
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
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
                    onChanged: (double newValue) async {
                      setState(() {
                        sliderValue = newValue;
                      });
                      await player.play(AssetSource('sounds/tick.wav'));
                    },
                  ),
                ),
                const Text(
                  'Vous êtes : ',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.indigo),
                  underline: Container(
                    height: 2,
                    color: Colors.indigo,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Homme', 'Femme', 'Autre']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Liste des boutons radio pour le genre
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dans quel secteur travaillez-vous : ',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile<Sector>(
                      title: const Text(
                        'Public',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      activeColor: Colors.indigo,
                      value: Sector.public,
                      groupValue: _sector,
                      onChanged: (Sector? value) {
                        setState(() {
                          _sector = value;
                        });
                      },
                    ),
                    RadioListTile<Sector>(
                      title: const Text(
                        'Privé',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      activeColor: Colors.indigo,
                      value: Sector.prive,
                      groupValue: _sector,
                      onChanged: (Sector? value) {
                        setState(() {
                          _sector = value;
                        });
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: changeColor,
                  child: Card(
                    color: cardColor,
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                        child: Text(
                          'Couleur préférée',
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Bouton pour sélectionner la date
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                      'Capchat : Sélectionner la date du jour : '
                      '${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                      style: const TextStyle(color: Colors.indigo)),
                ),
                const SizedBox(height: 20),
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.indigo),
                  ),
                  onPressed: _validateForm,
                  child: const Text(
                    'Valider le formulaire',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
