import 'package:flutter/material.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/services/database.dart';
import 'package:flutter_project/shared/constants.dart';
import 'package:flutter_project/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> dishes = [
    'No dish',
    'Ayam Sambal',
    'Ikan Goreng',
    'Sambal Sotong',
    'Ayam Percik'
  ];
  final List<String> sides = [
    'No sides',
    'Ulam Raja',
    'Sambal Belacan',
    'Budu',
    'Sambal Asam'
  ];

  //form values
  String _currentName;
  int _currentRice;
  String _currentDish;
  String _currentSides;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(userID: user.userID).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Custom order', style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  Text('Nasi:', style: TextStyle(fontSize: 18.0)),
                  Slider(
                    value: (_currentRice ?? userData.rice).toDouble(),
                    activeColor: Colors.brown[_currentRice ?? userData.rice],
                    inactiveColor: Colors.brown[_currentRice ?? userData.rice],
                    min: 0.0,
                    max: 500.0,
                    divisions: 5,
                    onChanged: (val) =>
                        setState(() => _currentRice = val.round()),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentDish ?? userData.dish,
                    items: dishes.map((dish) {
                      return DropdownMenuItem(
                        value: dish,
                        child: Text('$dish'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentDish = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSides ?? 'No sides',
                    items: sides.map((side) {
                      return DropdownMenuItem(
                        value: side,
                        child: Text('$side'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSides = val),
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child:
                        Text('Confirm', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(userID: user.userID)
                            .updateUserData(
                                _currentName ?? userData.name,
                                _currentRice ?? userData.rice,
                                _currentDish ?? userData.dish,
                                _currentSides ?? userData.sides);
                      }
                      ;
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
