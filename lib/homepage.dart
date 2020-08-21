import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.email}) : super(key: key);
  final String email;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
              child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text("LogOut"),
                  color: Colors.redAccent,
                  hoverColor: Colors.redAccent[100],
                  elevation: 20.0,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('email');                       
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
                  }),
                   RaisedButton(
                  child: Text("Map"),
                  color: Colors.redAccent,
                  hoverColor: Colors.redAccent[100],
                  elevation: 20.0,
                  onPressed: () {Map();}),
            ],
          )),
        ),
      ),
    );
  }
}
