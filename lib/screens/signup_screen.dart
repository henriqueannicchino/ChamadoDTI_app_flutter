import 'package:chamadodti/reusable_widgets/reusable_widget.dart';
import 'package:chamadodti/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

TextEditingController _passwordTextController = TextEditingController();
TextEditingController _registrationOrSiapeTextController = TextEditingController();
TextEditingController _userNameTextController = TextEditingController();
class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("1a1a1d"),
            hexStringToColor("1EAAF1")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, 3, _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Registration or Siape", Icons.person_outline, 1, _registrationOrSiapeTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, 2, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseFirestore.instance.collection("user")
                  .add({
                    "name": _userNameTextController.text,
                    "registrationOrSiape": _registrationOrSiapeTextController.text
                  }); 
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _registrationOrSiapeTextController.text + "@email.com",
                    password: _passwordTextController.text
                  ).then((value) {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen(userName: _userNameTextController.text, registrationOrSiape: _registrationOrSiapeTextController.text)));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ]
            ),
          )
        ),
      ),
    );
  }
}