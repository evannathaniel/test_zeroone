import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'login.dart';

class MyRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(primarySwatch: buildMaterialColor(Color(0xFF5487FF))),
      home: Register(),
    );
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  TextEditingController _id_cont = TextEditingController();
  TextEditingController _email_cont = TextEditingController();
  TextEditingController _pass_cont = TextEditingController();
  bool checkedValue = true;
  @override
  void initState() {
    super.initState();

    _id_cont.text = "";
    _pass_cont.text = "";
    _email_cont.text = "";
  }

  void register() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user_name", _id_cont.text);
    main();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF5487FF),
        body:Center(child:  ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ListTile(
              leading: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              title: Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              border: Border.all(width: 2, color: Colors.white),
              color: Colors.white,
            ),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Image.asset('images/img.png'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _id_cont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'User name',
                      hintText: 'Enter User name',
                      fillColor: Colors.grey.shade300,
                      filled: true),
                  onSubmitted: (v) {
                    _id_cont.text = v;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _id_cont,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      fillColor: Colors.grey.shade300,
                      filled: true),
                  onSubmitted: (v) {
                    _id_cont.text = v;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: _pass_cont,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelText: 'Password',
                      hintText: 'Enter password',
                      fillColor: Colors.grey.shade300,
                      filled: true),
                  onSubmitted: (v) {
                    _pass_cont.text = v;
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: CheckboxListTile(
                  title: RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: 'I agree with, ',
                          style: new TextStyle(color: Colors.black),
                        ),
                        new TextSpan(
                          text: 'Terms and Privacy',
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              launch('https://google.com');
                            },
                        ),
                      ],
                    ),
                  ),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(25)),
                    child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white)))),
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: 'Already have account?, ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      new TextSpan(
                        text: 'Log In',
                        style: new TextStyle(color: Colors.blue),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLogin()));
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )
        ])));
  }
}
