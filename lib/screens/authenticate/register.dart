import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_project/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () {
              //Navigator.push(
              //context,
              //PageTransition(
              //type: PageTransitionType.leftToRight,
              //child: widget.toggleView()));
              widget.toggleView();
            },
          )
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bga.jpg'), fit: BoxFit.cover)),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(5, 60, 5, 10),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Delivery Made Easy',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 30),
                  )),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    //username
                    TextFormField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'abc@gmail.com',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic)),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    //password
                    TextFormField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: '123456',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic)),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
