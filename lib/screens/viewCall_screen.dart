import 'package:chamadodti/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewCall extends StatelessWidget {
  final String userName, registrationOrSiape, status, createdBy, patrimonyNumber, block, room, description;
  final int numCall;


  ViewCall({Key? key, 
    required this.userName, 
    required this.registrationOrSiape, 
    required this.numCall,
    required this.status,
    required this.createdBy,
    required this.patrimonyNumber,
    required this.block,
    required this.room,
    required this.description
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizar Chamado"),
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
              height: 40,
            ),
            Text("Número do Chamado: $numCall"),
            SizedBox(
              height: 40,
            ),
            Text("Status: $status"),
            SizedBox(
              height: 20,
            ),
            Text("Aberto por: $createdBy"),
            SizedBox(
              height: 20,
            ),
            Text("Tombo do Equipamento: $patrimonyNumber"),
            SizedBox(
              height: 20,
            ),
            Text("Bloco: $block"),
            SizedBox(
              height: 20,
            ),
            Text("Sala: $room"),
            SizedBox(
              height: 20,
            ),
            Text("Descrição: $description"),
          ],
        )
      ),
    );
  }
}