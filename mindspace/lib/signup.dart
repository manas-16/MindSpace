import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindspace/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class sign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'signup',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new signup(),
    );
  }
}

class signup extends StatefulWidget {
  signup({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _signup createState() => new _signup();
}

class _signup extends State<signup> {
  final TextEditingController _textemail = new TextEditingController();
  final TextEditingController _textpass = new TextEditingController();
  final TextEditingController _textname = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreinstance = FirebaseFirestore.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;
  final String user_id = "J6OcMlf0eYMSKI76aoOV";


  Future<User> _signupemail(String email) {
    return(handleSignUp(email,_textpass.text,_textname));
  }


  Future<User> handleSignUp(email, password,name) async {

    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = result.user;

    assert (user != null);
    assert (await user.getIdToken() != null);
    print(user);
    return user;

  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child:Text(
                      "MindSpace",style: TextStyle(fontSize: 70.0,color: Colors.white),
                    )
                ),
                SizedBox(height: 40.0,),
                Center(
                    child:Text(
                      "Sign Up",style: TextStyle(fontSize: 40.0,color: Colors.white),
                    )
                ),
                new SizedBox(height:100.0),
                Container(
                  width:500.0,
                  child:TextField(
                    controller: _textname,
                    onSubmitted: _signupemail,
                    style: new TextStyle(fontSize: 30.0,),
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: new TextStyle(fontSize: 30.0,),
                      suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),child: Icon(Icons.account_circle,size:40.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                new SizedBox(height:40.0),
                Container(
                  width:500.0,
                  child:TextField(
                    controller: _textemail,
                    onSubmitted: _signupemail,
                    style: new TextStyle(fontSize: 30.0,),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: new TextStyle(fontSize: 30.0,),
                      suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),child: Icon(Icons.email,size:40.0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0,),
                Container(
                  width:500.0,
                  child:TextField(
                    obscureText: true,
                    style: new TextStyle(fontSize: 30.0,),
                    controller: _textpass,
                    onSubmitted: _signupemail,
                    decoration: InputDecoration(
                      hintText: 'Password',hintStyle: new TextStyle(fontSize: 30.0,),
                      suffixIcon: Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),child: Icon(Icons.visibility_off,size:40.0,),),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0,),
                new Container(
                  child:ButtonTheme(
                      height: 80.0,
                      minWidth: 200.0,
                      buttonColor: Colors.greenAccent,
                      child:RaisedButton(
                        onPressed: () async{
                          _signupemail(_textemail.text).then((User user) async {
                            if(_textname!=""){
                              user.updateProfile(displayName: _textname.text);
                              Navigator.pop(context);
                              Navigator.push(context, new MaterialPageRoute(builder: (context) => new Menu(name:_textname.text)));
                            }
                          }).catchError((e) => print(e));
                        },
                        child: const Text("Sign Up", style: TextStyle(fontSize: 40,color: Colors.black)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      )
                  ),
                ),
                /*SizedBox(height: 80.0,),
                Container(
                  height: 80.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                        image:AssetImage('Assets/google.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),*/
              ]
          )
      ),
    );
  }
}