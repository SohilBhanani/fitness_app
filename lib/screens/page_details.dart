import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/models/user.dart';
import 'package:flutter/material.dart';

class PageDetails extends StatefulWidget {
  User pageUser;
  String _name;
  String _email;
  var _dateofbirth;
  String _fetchgender;

  PageDetails(this.pageUser,this._name, this._email, this._dateofbirth, this._fetchgender);

  @override
  _PageDetailsState createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  
  TextEditingController _nameController;
  TextEditingController _emailController;
//  DateTime date1 = DateTime.now();
  DateTime date1;

  void changeDate(var volt){
     date1 = volt.toDate();
  }


  List<bool> isSelected;

  @override
  void initState() {
    changeDate(widget._dateofbirth);
    isSelected = [
      widget._fetchgender == 'male' ? true : false,
      widget._fetchgender == 'female' ? true : false
    ];
    _nameController = TextEditingController(text: widget._name);
    _emailController = TextEditingController(text: widget._email);
    super.initState();
  }

    var presentDate;
//
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

    int genderInt;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Edit your details"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                        child: Hero(
                          tag: 'detailHero',
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text('User Details',
                            style: TextStyle(fontSize: 32.0)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _nameController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    validator: (val) => val.isEmpty ? 'Enter Name' : null,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black),
                    validator: (val) => val.isEmpty ? 'Enter Email' : null,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: ToggleButtons(
                      borderColor: Colors.deepPurpleAccent,
                      fillColor: Colors.deepPurpleAccent,
                      borderWidth: 1,
                      selectedBorderColor: Colors.deepPurpleAccent,
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
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Date of Birth',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () => _selectDate1(context),
                          child: Text(
                            "${date1.day}-${date1.month}-${date1.year}",

                            style:
                                TextStyle(fontSize: 28.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ButtonTheme(
                    buttonColor: Colors.deepPurple,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        UpdateDetail();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void UpdateDetail(){
    Firestore.instance.collection('users').document(widget.pageUser.uid).updateData({
      'displayName' : _nameController.text,
      'email' : _emailController.text,
      'dob' : date1,
      'gender' : genderInt == 0? 'male' : 'female'
    });
  }
}
