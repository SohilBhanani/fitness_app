import 'package:flutter/material.dart';

class CaloriePage extends StatefulWidget {
  @override
  _CaloriePageState createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  List<String> activities = [
    'Sedentary(little or no exercise)',
    '1-3 days/week',
    '3-5 days/week',
    '6-7 days/week',
    '7 days + Demanding Job',
  ];

  var _currentSelectedValue;
  TextEditingController _ageFieldControllerCalorie = TextEditingController();
  TextEditingController _heightFieldControllerCalorie = TextEditingController();
  TextEditingController _weightFieldControllerCalorie = TextEditingController();
  var _bmr;
  int hell;
  var _update;

  bool _isMale() {
    if (hell == 0) {
      return true;
    } else {
      return false;
    }
  }

  void _calculateBMR() {
    setState(() {
      double height = double.parse(_heightFieldControllerCalorie.text);
      double weight = double.parse(_weightFieldControllerCalorie.text);
      int age = int.parse(_ageFieldControllerCalorie.text);

      var sub1 = (height * 10) / 10;
      var f2 = sub1.toInt();
      height = (f2) + ((height * 10.0) - (f2 * 10));
      double weightInKg = weight * 0.453592;
      double heightInCm = height * 30.48;

      //Men: BMR = 88.362 + (13.397 x weight in kg) + (4.799 x height in cm) - (5.677 x age in years)
      //Women: BMR = 447.593 + (9.247 x weight in kg) + (3.098 x height in cm) - (4.330 x age in years)

      if (_isMale()) {
        _bmr = 88.362 +
            (13.397 * weightInKg) +
            (4.799 * heightInCm) -
            (5.677 * age);
      } else {
        _bmr = 447.593 +
            (9.247 * weightInKg) +
            (3.098 * heightInCm) -
            (4.330 * age);
      }

      switch (_currentSelectedValue) {
        case 'Sedentary(little or no exercise)':
          _bmr = _bmr * 1.2;
          break;
        case '1-3 days/week':
          _bmr = _bmr * 1.375;
          break;
        case '3-5 days/week':
          _bmr = _bmr * 1.55;
          break;
        case '6-7 days/week':
          _bmr = _bmr * 1.725;
          break;
        case '7 days + Demanding Job':
          _bmr = _bmr * 1.9;
          break;
      }
    });
  }

  List<bool> isSelected1;

  @override
  void initState() {
    isSelected1 = [false, false];
    super.initState();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/calorie.png',
                  scale: 2.5,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Result is based on ',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Revised Harris-Benedict Equation',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: <Widget>[
                Text(
                  _update != null ? _update.toStringAsFixed(3) : "Hello",
                  style: TextStyle(fontSize: 25.0),
                ),
                Text('Calories Burned')
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    color: Color(0xff510E80),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Age',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 50.0, color: Colors.white),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          controller: _ageFieldControllerCalorie,
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
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        TextField(
                          style: TextStyle(fontSize: 50.0, color: Colors.white),
                          controller: _heightFieldControllerCalorie,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(border: InputBorder.none),
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
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 50.0, color: Colors.white),
                    controller: _weightFieldControllerCalorie,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
            ),
            Center(
              child: ToggleButtons(
                borderColor: Color(0xff510E80),
                fillColor: Color(0xff510E80),
                borderWidth: 1,
                selectedBorderColor: Color(0xff510E80),
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
                    hell = index;
                    for (int i = 0; i < isSelected1.length; i++) {
                      isSelected1[i] = i == index;
                    }
                  });
                },
                isSelected: isSelected1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        helperText: 'Choose Activity',
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                    isEmpty: _currentSelectedValue == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedValue,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue = newValue;
                            state.didChange(newValue);
                          });

                        },
                        items: activities.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
//            RaisedButton(onPressed: () {
//              _calculateBMR();
//              _update = _bmr;
//              print(_bmr);
//              print(hell);
//            }),
            ButtonTheme(
              height: 55,
              child: RaisedButton(
                shape: CircleBorder(),
                onPressed: (){
                  _calculateBMR();
                  _update = _bmr;
                  print(_bmr);
                  print(hell);
                },
                child: Icon(Icons.keyboard_arrow_right),
                color: Colors.purple[800],
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
