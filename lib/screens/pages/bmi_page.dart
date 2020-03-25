import 'package:flutter/material.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {
  double _calculation;
  String _calcResult;
  String _result;

  TextEditingController _ageFieldController = TextEditingController();
  TextEditingController _heightFieldController = TextEditingController();
  TextEditingController _weightFieldController = TextEditingController();

  void _calculateBMI() {
    double height = double.parse(_heightFieldController.text);
    double weight = double.parse(_weightFieldController.text);
    double sub;
    int fl;
    if (height != null && weight != null) {
      setState(() {
        sub = (height*10)/10;
        fl = sub.toInt();
        weight = weight ;
        height = (fl * 12.0)+((height*10.0)-(fl*10));
        _calculation = (weight / (height * height))*703;
        _calcResult = _calculation.toStringAsFixed(2);
        if (_calculation < 18.5) {
          _result = 'Underweight';
        } else if (_calculation >= 18.5 && _calculation <= 24.9) {
          _result = 'Goodfit';
        } else if (_calculation >= 25.0 && _calculation <= 29.9) {
          _result = 'Overweight';
        } else {
          _result = 'Obese';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/bmi.png',
                    scale: 6,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _calcResult != null ? '$_calcResult' : 'hello',
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 44.5,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    _result != null ? _result : 'Have a nice day',
                    style: TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                  Text("Check Your BMI",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 25.0,),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          color: Color(0xff510E80),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Age',
                                style: TextStyle(fontSize: 18.0,color: Colors.white),
                              ),
                              TextField(
                                style: TextStyle(fontSize: 50.0,color: Colors.white),
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                controller: _ageFieldController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: Color(0xff510E80),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Feet',
                                style: TextStyle(fontSize: 18.0,color: Colors.white),
                              ),
                              TextField(
                                style: TextStyle(fontSize: 50.0,color:Colors.white),
                                controller: _heightFieldController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  border: InputBorder.none
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    color: Color(0xff510E80),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Weight (Pound)',
                          style: TextStyle(fontSize: 18.0,color: Colors.white),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 50.0,color:Colors.white),
                          controller: _weightFieldController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(padding: const EdgeInsets.all(7.5)),
                  ButtonTheme(
                    height: 55,
                    child: RaisedButton(
                      shape: CircleBorder(),
                      onPressed: _calculateBMI,
                      child: Icon(Icons.keyboard_arrow_right),
                      color: Colors.purple[800],
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
