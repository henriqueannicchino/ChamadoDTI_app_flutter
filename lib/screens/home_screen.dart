import 'package:chamadodti/screens/numCall.dart';
import 'package:chamadodti/screens/openCall_screen.dart';
import 'package:chamadodti/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';

class HomeScreen extends StatelessWidget {
  final String userName;
  final String registrationOrSiape;

  HomeScreen({Key? key, required this.userName, required this.registrationOrSiape}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Usuário: $userName')
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Matricula: $registrationOrSiape")
                        ),
                      ],
                    )
                  ),
                  ElevatedButton(
                    child: Text("Sair"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        //print("Signed Out");
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => SignInScreen()));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 200,
              ),
              ButtonTheme(
                minWidth: 340.0,
                height: 35.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  child: Text("Abrir Chamado"),
                  onPressed: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => OpenCallScreen(userName: userName, registrationOrSiape: registrationOrSiape)));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                minWidth: 340.0,
                height: 35.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  child: Text("Acompanhar Chamado"),
                  onPressed: () {
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => NumCall(userName: userName, registrationOrSiape: registrationOrSiape)));
                  },
                ),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}