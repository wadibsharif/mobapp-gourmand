import 'package:flutter/material.dart';
import 'package:flutter_project/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> dishes = ['1', '2', '3', '4', '5'];
  final List<String> sides = ['a', 'b', 'c', 'd', 'e'];

  //form values
  String _currentName;
  int _currentRice;
  String _currentDish;
  String _currentSides;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('Update order', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Name'),
            validator: (val) => val.isEmpty ? 'Enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          Slider(
            value: (_currentRice ?? 100).toDouble(),
            activeColor: Colors.brown[_currentRice ?? 100],
            inactiveColor: Colors.brown[_currentRice ?? 100],
            min: 100.0,
            max: 600.0,
            divisions: 5,
            onChanged: (val) => setState(() => _currentRice = val.round()),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentDish ?? '1',
            items: dishes.map((dish) {
              return DropdownMenuItem(
                value: dish,
                child: Text('$dish dish'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentDish = val),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSides ?? 'a',
            items: sides.map((side) {
              return DropdownMenuItem(
                value: side,
                child: Text('$side sides'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentSides = val),
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.pink[400],
            child: Text('Update', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              print(_currentName);
              print(_currentRice);
              print(_currentDish);
              print(_currentSides);
            },
          )
        ],
      ),
    );
  }
}
