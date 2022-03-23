import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_zeroone/login.dart';

String user = "";
Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_name = prefs.getString("user_name") ?? '';
  return user_name;
}

void main() {
  checkUser().then((String result) {
    if (result == '')
      runApp(MyLogin());
    else {
      user = result;
      runApp(MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("user_name", '');
  showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text('Log Out'),
                  content: Text('Berhasil Log Out'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ));
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF5487FF),
        body: Center(
            child: ListView(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ListTile(
              leading: GestureDetector(
                  child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                
              ),
              onTap: logout,),
              title: Text(
                'Home',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height - 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              border: Border.all(width: 2, color: Colors.white),
              color: Colors.white,
            ),
            child: Text(
              'Welcome ' + user,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF5487FF),
                  fontWeight: FontWeight.bold),
            ),
          )
        ])) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
