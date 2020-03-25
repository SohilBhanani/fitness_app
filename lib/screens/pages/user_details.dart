import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/models/user.dart';
import 'package:fitnessapp/screens/camera_screen.dart';
import 'package:fitnessapp/screens/page_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsPage extends StatelessWidget {
  User newUser;
  var cameras;
  UserDetailsPage(this.newUser, this.cameras);

  @override
  Widget build(BuildContext context) {
    print(newUser.uid);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .where('userid', isEqualTo: newUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('Loading Data.. Please Wait');
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: <Widget>[
                          Hero(
                            tag: 'detailHero',
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  size: 25,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PageDetails(
                                          newUser,
                                          snapshot.data.documents[0]
                                              ['displayName'],
                                          snapshot.data.documents[0]['email'],
                                          snapshot.data.documents[0]['dob'],
                                          snapshot.data.documents[0]
                                              ['gender'])));
                                },
//
                              ),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Image.asset(
                            'assets/user.png',
                            scale: 8.5,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        snapshot.data.documents[0]['displayName'],
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 32.0),
                        ),
                      ),
                      Text(
                        'Birthdate: ' +
                            '${(snapshot.data.documents[0]['dob']).toDate().day}' +
                            '-' +
                            '${(snapshot.data.documents[0]['dob']).toDate().month}' +
                            '-' +
                            '${(snapshot.data.documents[0]['dob']).toDate().year}',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        snapshot.data.documents[0]['email'],
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        snapshot.data.documents[0]['gender'],
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 22.0),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      //Camera Button
                      ButtonTheme(
                        buttonColor: Colors.deepPurple,
                        height: 55.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CameraScreen(cameras)),
                            );                          },
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
