import 'package:fitnessapp/models/user.dart';
import 'package:fitnessapp/screens/authenticate/authenticate.dart';
import 'package:fitnessapp/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  var cameras;
  Wrapper(this.cameras);
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage(cameras);
    }

  }
}