import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/services/auth.dart';

import '../../shared/loading.dart';
import 'authenticate.dart';

class GuestSignIn extends StatefulWidget {
  @override
  _GuestSignInState createState() => _GuestSignInState();
}

class _GuestSignInState extends State<GuestSignIn> {


  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController=TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[

            TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                  border: OutlineInputBorder(),
                )
            ),

            TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                )
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.app_registration),
              label: Text('Register User'),
              onPressed: () {
               _register();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  // bool loading = false;
  // final _formKey = GlobalKey<FormState>();
  // final AuthService _auth = AuthService();
  // @override
  // Widget build(BuildContext context) {
  //
  //
  // }
  //   return loading ? Loading() :
  //   Container(
  //       child: Column (
  //         children: [
  //           Form (
  //             key: _formKey,
  //             autovalidateMode: AutovalidateMode.always,
  //             child: TextFormField(
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Enter a search term',
  //               ),
  //               validator: (value) => EmailValidator.validate(value!) ? null : "Please enter an email",
  //             ),
  //
  //           ),
  //           Row(
  //             children:  [
  //
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   //change width and height on your need width = 200 and height = 50
  //                   minimumSize: Size(230, 30),
  //                 ),
  //               onPressed: () async {
  //                 if (_formKey.currentState!.validate()) {
  //                   setState(() => loading = true);
  //                   dynamic result = await _auth.signInAnon();
  //                   if (result == null)
  //                   {
  //                     setState(() => loading = false);
  //                     print(' error');
  //                   } else{
  //                     print('Sign In');
  //                     print(result.Uid);
  //
  //                   }
  //
  //                 } else {
  //                   print(' error masuk pas betul2 nyah');
  //                 }
  //
  //               },
  //               child: const Text('Submit'),
  //             ),
  //
  //
  //             ]
  //           ),
  //
  //
  //         ],
  //       )
  //   );
  //
  //
  //
  // }

}

// Container(
//
// padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
// child: ElevatedButton(
// child:const Text("Sign IN"),
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.purple,
// padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
// textStyle: TextStyle(fontSize: 15,
// fontWeight: FontWeight.bold)),
//
//
//
// onPressed: () async {
//
// setState(() => loading = true);
// dynamic result = await _auth.signInAnon();
// if (result == null)
// {
// setState(() => loading = false);
// print(' error');
// } else{
// print('Sign In');
// print(result.Uid);
//
// }
// },
//
// )
//
// );