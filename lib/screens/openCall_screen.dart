import 'package:chamadodti/reusable_widgets/reusable_widget.dart';
import 'package:chamadodti/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chamadodti/screens/viewCall_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController _equipmentPatrimonyNumberTextController = TextEditingController();
TextEditingController _blockTextController = TextEditingController();
TextEditingController _roomTextController = TextEditingController();
TextEditingController _problemDescriptionController = TextEditingController();

class OpenCallScreen extends StatelessWidget {
  final String userName;
  final String registrationOrSiape;

  OpenCallScreen({Key? key, required this.userName, required this.registrationOrSiape}) : super(key: key);

  void saveCall(BuildContext context) async {
    final queryData = await FirebaseFirestore.instance
      .collection('call').orderBy("numCall", descending: true).limit(1).get();

    int numCall = queryData.docs.length > 0 ? queryData.docs[0]['numCall']+1 : 1;

    FirebaseFirestore.instance.collection("call")
      .add({
        "numCall": numCall,
        "status": "Pendente",
        "createdBy": userName,
        "patrimonyNumber": _equipmentPatrimonyNumberTextController.text,
        "block": _blockTextController.text,
        "room": _roomTextController.text,
        "description": _problemDescriptionController.text,
        "createdAt": FieldValue.serverTimestamp()
      });

    Navigator.push(context, 
      MaterialPageRoute(builder: (context) => 
        ViewCall(
          userName: userName, 
          registrationOrSiape: registrationOrSiape, 
          numCall: numCall,
          status: "Pendente",
          createdBy: userName,
          patrimonyNumber: _equipmentPatrimonyNumberTextController.text,
          block: _blockTextController.text,
          room: _roomTextController.text,
          description: _problemDescriptionController.text
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Abrir Chamado"),
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
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Tombo do equipamento"),
              ),
              reusableTextField("Digite o tombomento do equipamento", Icons.computer_outlined, 1, _equipmentPatrimonyNumberTextController),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Bloco"),
              ),
              reusableTextField("Digite o nome do Bloco onde está a sala", Icons.roofing_outlined, 3, _blockTextController),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Sala"),
              ),
              reusableTextField("Digite o nome da sala", Icons.room_outlined, 3, _roomTextController),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Descreva o Problema"),
              ),
              TextField(
                controller: _problemDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration( 
                  hintText: "Digite o problema que o dispositivo está apresentando",
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(15),
                  ),
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
                  child: Text("Abrir Chamado"),
                  onPressed: () {
                    
                    saveCall(context);

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