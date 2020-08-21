import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/homepage.dart';
import 'package:login/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email,pass;
  
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      setState(() {
        isLoading = true;
      });
      return false;
    }
  }


addstringtoSF(String e) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', e);
}
  void login() async{
    if(validateAndSave()){
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)
    .then((user){
      Navigator.pop(context,true);
      addstringtoSF(email);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage(email:email)));
    }).catchError((e){
      print(e);
    });
    }

  }


  @override
  Widget build(BuildContext context) {
    final _width=MediaQuery.of(context).size.width;
    final _height=MediaQuery.of(context).size.height;
    return Container(
      color: Colors.redAccent,
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                
                //Title Field
                Container(
                  height: _height * 0.07,
                  width: _width * 1.0,
                  margin: EdgeInsets.only(top: 170),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                //Email Field
                Container(
                  height: _height * 0.1,
                  width: _width * 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) =>
                          value.isEmpty ? "Email can't be empty" : null,
                    ),
                  ),
                ),
                //password Filed
                Container(
                  height: _height * 0.1,
                  width: _width * 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      onChanged: (value) => pass = value,
                      validator: (value) =>
                          value.isEmpty ? "Password can't be empty" : null,
                    ),
                  ),
                ),
                //login Button
                Container(
                  height: _height * 0.07,
                  width: _width * 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60, right: 60),
                    child: RaisedButton(
                      color: Colors.redAccent,
                      hoverColor: Colors.redAccent[100],
                      elevation: 20.0,
                      onPressed: () async {
                        
                      },
                      child: Text('Login'),
                    ),
                    
                    
                  ),
                ),
                SizedBox(height: 20.0,),
                //new user
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("New User?"),
                    InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Signup()));
                      },
                      child: Text("Signup"
                      ,style: TextStyle(fontWeight: FontWeight.w600),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}