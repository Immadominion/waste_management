import 'package:flutter/material.dart';
import 'package:waste_management/services/auth.dart';
import 'package:waste_management/shared/loading.dart';

class WorkerSignIn extends StatefulWidget {
  @override
  _WorkerSignIn createState() => _WorkerSignIn();
}

class _WorkerSignIn extends State<WorkerSignIn> {
  bool loading = false;

  String Email = '';
  String Password = '';

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Sign In As Guest")
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  onChanged: (val) {
                    setState(() => Email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => Password = val);
                  },
                ),
                SizedBox(height: 20.0,),
                ElevatedButton(
                  child:const Text("Sign IN"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      textStyle: TextStyle(fontSize: 15,
                          fontWeight: FontWeight.bold)),



                  onPressed: () async {
                    print(Email);
                  },

                )
              ],
            ),
          )
      ),
    );
  }

}