import 'package:fitnessapp/models/user.dart';
import 'package:fitnessapp/screens/wrapper.dart';
import 'package:fitnessapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
WidgetsFlutterBinding.ensureInitialized();
cameras = await availableCameras();
runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(cameras),
      ),
    );
  }
}