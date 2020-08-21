import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/loginpage.dart';

import 'crud.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email,pass,phone,name;
  CRUD obj=new CRUD();
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


  void insert(BuildContext context){
    Map<String,dynamic> signupdata={
      'name':name,
      'email':email,
      'pass':pass,
      'phone':phone
    };
  obj.addData(signupdata,context).then((result){}).catchError((e){
    print(e);
    print("inserted");
  });
  }
  void register() async{
    if(validateAndSave()){
    FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email, password: pass)
              .then((user) {
            setState(() {
              insert(context);
            });
            var alertDialog = AlertDialog(
              title: Text("Account Created Successfully"),
              content: Text("Please Do Login"),
              actions: <Widget>[
                FlatButton(
                    child: new Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                  ),
              ],
            );

            showDialog(
                context: context,
                builder: (BuildContext context) => alertDialog);
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
                  margin: EdgeInsets.only(top: 70),
                  child: Center(
                    child: Text(
                      'SignUp',
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
                //name
                Container(
                  height: _height * 0.1,
                  width: _width * 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) =>
                          value.isEmpty ? "Name can't be empty" : null,
                    ),
                  ),
                ),
                //phone
                Container(
                  height: _height * 0.1,
                  width: _width * 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Phone',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => email = value,
                      validator: (value) =>
                          value.isEmpty ? "Phone can't be empty" : null,
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
                        register();
                      },
                      child: Text('Register'),
                    ),
                    
                    
                  ),
                ),
                SizedBox(height: 20.0,),
                //new user
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Have Account?"),
                    InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                      },
                      child: Text("Login"
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