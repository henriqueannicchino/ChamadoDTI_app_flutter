import 'package:chamadodti/reusable_widgets/reusable_widget.dart';
import 'package:chamadodti/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chamadodti/screens/viewCall_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController _callNumberTextController = TextEditingController();
class NumCall extends StatelessWidget {
  final String userName;
  final String registrationOrSiape;

  const NumCall({Key? key, required this.userName, required this.registrationOrSiape}) : super(key: key);

  void getCall(BuildContext context, int numCall) async {
    final queryData = await FirebaseFirestore.instance
      .collection('call')
      .where('numCall', isEqualTo: numCall)
      .limit(1)
      .get();

    if (queryData.docs.length > 0){
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => 
          ViewCall(
            userName: userName,
            registrationOrSiape: registrationOrSiape,
            numCall: numCall,
            status: queryData.docs[0]['status'].toString(),
            createdBy: queryData.docs[0]['createdBy'].toString(),
            patrimonyNumber: queryData.docs[0]['patrimonyNumber'].toString(),
            block: queryData.docs[0]['block'].toString(),
            room: queryData.docs[0]['room'].toString(),
            description: queryData.docs[0]['description'].toString()
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digitar Num Chamado"),
      ),
      body: SingleChildScrollView(
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
                        child: Text("Usuário: $userName")
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
                      print("Signed Out");
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Número do Chamado"),
              ),
              reusableTextField("Digite o número do chamado", Icons.numbers, 1, _callNumberTextController),
              SizedBox(
                height: 180,
              ),
              ButtonTheme(
                minWidth: 340.0,
                height: 35.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  child: Text("Visualizar"),
                  onPressed: () {
                    getCall(context, int.parse(_callNumberTextController.text));
                    //checar se chamado existe antes mudar de pagina
                    /*Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => 
                        ViewCall(
                          userName: userName,
                          registrationOrSiape: registrationOrSiape,
                          numCall: int.parse(_callNumberTextController.text) 
                        )
                      )
                    );*/
                  },
                ),
              ),
          ],
        )
      )
    );
  }
}