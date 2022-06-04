import 'package:chamadodti/reusable_widgets/reusable_widget.dart';
import 'package:chamadodti/screens/home_screen.dart';
import 'package:chamadodti/screens/signup_screen.dart';
import 'package:chamadodti/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignInScreen  extends StatefulWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _registrationOrSiapeTextController = TextEditingController();

  String userName = "";

  void getUser(String userRegistrationOrSiape) async {

    final queryData = await FirebaseFirestore.instance
      .collection('user')
      .where('registrationOrSiape', isEqualTo: userRegistrationOrSiape)
      .get();

    Navigator.push(context,
      MaterialPageRoute(builder: (context) => HomeScreen(userName: queryData.docs[0]['name'].toString(), registrationOrSiape: _registrationOrSiapeTextController.text)));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.png"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Use a Matrícula ou Siape", Icons.person_outline_outlined, 1, _registrationOrSiapeTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Digite sua senha", Icons.lock_outline, 2, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {

                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _registrationOrSiapeTextController.text + "@email.com",
                    password: _passwordTextController.text
                  ).then((value) {
                    getUser(_registrationOrSiapeTextController.text);
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });                  

                }),
                //signUpOption(),
                
              ],
            ),
          )
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
          style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}