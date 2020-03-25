import 'package:fitnessapp/models/user.dart';
import 'package:fitnessapp/screens/pages/bmi_page.dart';
import 'package:fitnessapp/screens/pages/calorie_page.dart';
import 'package:fitnessapp/screens/pages/user_details.dart';
import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  var cameras;
  HomePage(this.cameras);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
  final user = Provider.of<User>(context);


//    final user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("Health Buddy"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: PageView(

          children: <Widget>[
            UserDetailsPage(user, widget.cameras),
            BMIPage(),
            CaloriePage()
          ],
        ));
  }
}
