import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date1 = DateTime.now();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';
  String conf_password = '';
  String name = '';
  String dob = '';
  bool gender;

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date1,
        firstDate: DateTime(1890, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != date1)
      setState(() {
        date1 = picked;
      });
  }

  List<bool> isSelected;

  @override
  void initState() {
    isSelected = [false, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int genderInt;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      backgroundColor: Color(0xff7F84BE),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Hero(
              tag: 'pnghero',
              child: Image.asset('assets/lola.gif'),
            ),
//          Image.asset(
//            'assets/lola.gif',
//          ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                onChanged: (val) {
                  setState(() => name = val);
                },
                  validator: (val) => val.isEmpty ? 'Enter Name' : null,
                decoration: InputDecoration(
                  focusColor: Colors.white,

                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                keyboardType: TextInputType.emailAddress,
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
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Date of Birth',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 28.0,
                  ),
                  InkWell(
                    onTap: () => _selectDate1(context),
                    child: Text(
                      "${date1.day}-${date1.month}-${date1.year}",
                      style: TextStyle(fontSize: 28.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Center(
              child: ToggleButtons(
                borderColor: Colors.white,
                fillColor: Colors.deepPurpleAccent,
                borderWidth: 1,
                selectedBorderColor: Colors.white,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(0),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 15, right: 15),
                    child: Text(
                      'Male',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Female',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    genderInt = index;
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                isSelected: isSelected,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 18.0, right: 18.0),
              child: TextFormField(
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
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
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: TextFormField(
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => conf_password = val);
                },
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
                  hintText: "Confirm Password",
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonTheme(
                minWidth: 150.0,
                height: 50.0,
                child: RaisedButton(
                    child: const Text(
                      "Lets Go",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepPurpleAccent,
                    onPressed: () async {
                      if (password == conf_password) {
                        if (_formKey.currentState.validate()) {
                          dynamic result =
                              await _auth.  registerWithEmailAndPassword(
                                  name,
                                  email,
                                  date1,
                                  genderInt == 0 ? true : false,
                                  password);
                          print(result);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });
                          }
                        }
                      } else {
                        print('diff');
//                        ShowSnack();
                        final snackBar = SnackBar(
                          content: Text(
                            'Passwords do not match !',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
//
                        );

                        // it to show a SnackBar.
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }
                    }),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}
