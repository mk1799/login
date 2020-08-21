import 'package:flutter/material.dart';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUD{

bool checksignin() {
    if (FirebaseAuth.instance.currentUser != null)
      return true;
    else
      return false;
  }
  
  Future<void> addData(signupdata, BuildContext context) async {
    if (checksignin()) {
      Firestore.instance.collection('user').add(signupdata).catchError((e) {
        print(e);
      });
    } else {
      final snackBar = SnackBar(content: Text('Please Do Login'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


 
}