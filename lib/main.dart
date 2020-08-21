import 'package:flutter/material.dart';
import 'package:login/homepage.dart';
import 'package:login/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref=await SharedPreferences.getInstance();
  String spe;
  spe=pref.getString('email');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: spe != null ? HomePage(email:spe): LoginPage()
    )
  );
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Practical",
      home: SafeArea(child: Scaffold(
        body: LoginPage(),
      )),
    );
  }
}