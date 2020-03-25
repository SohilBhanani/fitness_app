import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(

        backgroundColor: Color(0xff7F84BE),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Hero(
                  tag: 'pnghero',
                  child: Image.asset('assets/lola.gif'),
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        hintText: 'Email'),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    cursorColor: Colors.white,
                    obscureText: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintText: "Password",
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: 180.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.deepPurpleAccent,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(
                              () {
                                error = 'Could not sign in with credentials';
                              },
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: 180.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.deepPurpleAccent,
                      onPressed: () => widget.toggleView(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
//                Padding(
//                  padding: const EdgeInsets.only(left: 128.0, right: 128.0),
//                  child: ButtonTheme(
//                    minWidth: 180.0,
//                    height: 50.0,
//                    child: RaisedButton(
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text("Sign In with"),
//                            SizedBox(
//                              width: 10.0,
//                            ),
//                            Image.asset(
//                              'assets/google.png',
//                              height: 25,
//                              width: 25,
//                            ),
//                          ],
//                        ),
//                        color: Colors.white,
//                        onPressed: () {}),
//                  ),
//                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ));
  }
}
