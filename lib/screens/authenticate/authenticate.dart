
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:waste_management/screens/authenticate/workersign.dart';

import '../../services/auth.dart';
import '../../shared/loading.dart';
import '../bekaphomeskren.dart';
import '../bottom_nav.dart';
import 'guestsign.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();


  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;
  bool ShowButonWorker = false;
bool ShowButonGuest = false;
  bool _isContainerVisible = false;
  bool _isContainerVisible2 = false;
  bool showSignIn = true;
  bool _canShowButtonGuest = true;
  bool _canShowButtonWorker = true;
  bool loading = false;
  String WorkerEmail = ' ';
  String WorkerPassword = ' ';
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  void hideWidget() {
    setState(() {
      _canShowButtonGuest = !_canShowButtonGuest;
    });
  }

  void hideWidget2() {
    setState(() {
      _canShowButtonWorker = !_canShowButtonWorker;
    });
  }
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController=TextEditingController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
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

  @override
  Widget build(BuildContext context) {
return loading ? Loading() : Scaffold(
    resizeToAvoidBottomInset: true,
  //extendBodyBehindAppBar: true,
  appBar:
  AppBar(
    //scrolledUnderElevation: ,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Text(""),

  ),
    body:SingleChildScrollView(
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //ROW 1
                children: const [
                  SizedBox(
                    height: 50,
                  ),

                  Text(
                    'DeDumpster',
                    style: TextStyle(fontSize: 55,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bauhaus'),
                  ),

                ],

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //ROW 1
                children: const [
                  SizedBox(
                    height: 25,
                  ),

                  Text(
                    '"Green Ways for Environment"',
                    style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bauhaus'),
                  ),

                ],

              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //ROW 1
                  children: [
                    Container(
                      height: 120.0,
                      width: 250.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'lib/screens/assets/images/logodepan.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ]

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //ROW 1
                children: const [
                  SizedBox(
                    height: 100,
                  ),

                  Text(
                    '- Sign In To Access More Feature -',
                    style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bauhaus'),
                  ),

                ],

              ),
              SizedBox(height: 50),
              ShowButonGuest // false
                  ? const SizedBox.shrink()
                  :
              !_canShowButtonWorker // false
                  ? const SizedBox.shrink()
                  :Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //ROW 1
                children:  [
                  Container(
                    width: 100, // <-- Your width
                    height: 40,
                    child:  ElevatedButton(
                      child: Text('Sign In'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        hideWidget2();
                        setState(() {
                          ShowButonWorker = !ShowButonWorker;
                          //_isContainerVisible2 = !_isContainerVisible2;
                        });
                      },
                    ),
                  ),


                  SizedBox(
                    width: 100, // <-- Your width
                    height: 40, // <-- Your height
                    child:

                    ElevatedButton(
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                      ),
                      onPressed: () {
                        hideWidget();
                        setState(() {
                          ShowButonGuest = !ShowButonGuest;
                          _isContainerVisible = !_isContainerVisible;
                        });
                      },
                    ),

                  ),

                ],

              ),
               Visibility(
        visible: ShowButonGuest,
        child:
                    Container(
                        child: Column (
                            children: [
                                Form (
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SizedBox(
            height: 65,
            width: 250,
            child: TextFormField(
              controller: _emailController,
              //style: TextStyle(fontSize: 40.0, height: 0.5,   color: Colors.black),
              decoration:  const InputDecoration(
                  helperText: ' ',
                border:  OutlineInputBorder(),
                hintText: 'Enter an Email',
                icon:  Padding(
                  padding: EdgeInsets.only(top: 3.0, ),
                  child: Icon(
                    PhosphorIcons.envelope_simple,
                    size: 35.0,
                    color: Color(0xff1c1c1c),
                  ),
                )
              ),
              validator: (value) => EmailValidator.validate(value!) ? null : "Please enter an email",
            ),
          ),


        ),
                              Form (

                      autovalidateMode: AutovalidateMode.always,
                      child: SizedBox(
                        height: 65,
                        width: 250,
                        child: TextFormField(
                          //style: TextStyle(fontSize: 40.0, height: 0.5,   color: Colors.black),
                          controller: _passwordController,
                          decoration:  const InputDecoration(
                              helperText: ' ',
                              border:  OutlineInputBorder(),
                              hintText: 'Enter Password',

                              icon:  Padding(
                                padding: EdgeInsets.only(top: 3.0, ),
                                child: Icon(
                                  PhosphorIcons.password,

                                  size: 35.0,
                                  color: Color(0xff1c1c1c),
                                ),
                              )
                          ),
                          obscureText: true,
                        ),
                      ),


                    ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children:  [

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //change width and height on your need width = 200 and height = 50
                  minimumSize: Size(250, 40),
                ),
                onPressed: () {
                  _register();
                },
                child: const Text('Register Now'),
              ),


            ]
        ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [

                                    ElevatedButton(
                                      child: Text('Back'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        hideWidget();
                                        setState(() {
                                          ShowButonGuest = !ShowButonGuest;

                                        });
                                      },
                                    ),


                                  ]
                              ),




        ],
      )
    ),


      ),
               Visibility(
                visible: ShowButonWorker,
                child:
                Container(
                    child: Column (
                      children: [
                        Form (
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [

                              SizedBox(
                                height: 65,
                                width: 250,
                                child: TextFormField(
                                  //style: TextStyle(fontSize: 40.0, height: 0.5,   color: Colors.black),
                                  decoration: const InputDecoration(
                                    helperText: ' ',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    hintText: 'Enter Email Address',
                                      icon:  Padding(
                                          padding:  EdgeInsets.only(top: 3.0, ),
                                          child: Icon(
                                            PhosphorIcons.user_square,
                                            size: 35.0,
                                            color: Color(0xff1c1c1c),
                                          )),
                                  ),
                                  validator: (value) => EmailValidator.validate(value!) ? null : "Please enter an email",
                                  onChanged: (val){

                                    setState(() => WorkerEmail = val);

                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                                width: 250,

                              ),

                              SizedBox(
                                height: 40,
                                width: 250,
                                child: TextFormField(
                                  //style: TextStyle(fontSize: 40.0, height: 0.5,   color: Colors.black),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    hintText: 'Enter Password',
                                    icon:  Icon(
                                      PhosphorIcons.lock_key,
                                      size: 35.0,
                                      color: Color(0xff1c1c1c),
                                    ),
                                  ),
                                  obscureText: true,
                                  onChanged: (val){

                                      setState(() => WorkerPassword = val);

                                  },
                                  //validator: (value) => EmailValidator.validate(value!) ? null : "Please enter an email",
                                ),
                              ),

                            ],
                          ),

                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [

                              ElevatedButton(

                                style: ElevatedButton.styleFrom(

                                  //change width and height on your need width = 200 and height = 50
                                  minimumSize: Size(250, 40),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(WorkerEmail, WorkerPassword);
                                    if (result == null)
                                    {
                                      setState(() => loading = false);
                                      print(' error');
                                    } else{
                                      print('Sign In');
                                      print(result.Uid);

                                    }

                                  } else {
                                    print(' error masuk pas betul2 nyah');
                                  }

                                },
                                child: const Text('Sign In'),
                              ),


                            ]
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [

                              ElevatedButton(
                                child: Text('Back'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  hideWidget2();
                                  setState(() {
                                    ShowButonWorker = !ShowButonWorker;
                                   // _isContainerVisible = _isContainerVisible;
                                  });
                                },
                              ),


                            ]
                        ),




                      ],
                    )
                ),


              ),
              SizedBox(height:10),
              ShowButonWorker // false
                  ? const SizedBox.shrink()
                  :!_canShowButtonGuest // false
                  ? const SizedBox.shrink()
                  :Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //ROW 1

                children:  [


                  // Container(
                  //   width: 100, // <-- Your width
                  //   height: 40,
                  //   child:  ElevatedButton(
                  //     child: Text('Login'),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blueAccent,
                  //     ),
                  //     onPressed: () {
                  //       hideWidget2();
                  //       setState(() {
                  //         ShowButonWorker = !ShowButonWorker;
                  //         //_isContainerVisible2 = !_isContainerVisible2;
                  //       });
                  //     },
                  //   ),
                  // ),

                ],

              ),


            ])
    ),

);

  }


}



class ColoredContainer extends StatelessWidget {
  ColoredContainer(this._isContainerVisible);
  final bool _isContainerVisible;

  @override
  Widget build(BuildContext context) {
    return Column (
children:  [
AnimatedContainer (
duration: Duration(milliseconds: 60),
//color: Colors.,
height: _isContainerVisible ? 170.0 : 0.0,
width: _isContainerVisible ? 230.0 : 0.0,
transformAlignment: Alignment.bottomCenter,
child: GuestSignIn()

)
    ]
    );
  }

}

class ColoredContainer2 extends StatelessWidget {
  ColoredContainer2(this._isContainerVisible2);
  final bool _isContainerVisible2;

  @override
  Widget build(BuildContext context) {
    return
      Column (
          children:  [
            AnimatedContainer (
                duration: Duration(milliseconds: 60),
//color: Colors.,
                height: _isContainerVisible2 ? 170.0 : 0.0,
                width: _isContainerVisible2 ? 230.0 : 0.0,
                transformAlignment: Alignment.bottomCenter,
                //child: //GuestSignIn()

            )
          ]
      );
  }

}
