import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindspace/Home.dart';
import 'package:mindspace/signup.dart';



class log extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return new MaterialApp(
          title: 'Login',
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: new login(),
        );
      },
    );
  }
}
/*    @override
    void initState() async{
      await Firebase.initializeApp();
      new MaterialApp(
      title: 'Login',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new login(),
    );
    }*/


class login extends StatefulWidget {
  login({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _login createState() => new _login();
}

class _login extends State<login> {
  final TextEditingController _textemail = new TextEditingController();
  final TextEditingController _textpass = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;


  Future<User> _logemail(String email) {
    return(handleSignInEmail(email,_textpass.text));
  }


  Future<User> handleSignInEmail(String email, String password) async {

    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final User currentUser = await auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInEmail succeeded: $user');

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
                    "Sign in",style: TextStyle(fontSize: 40.0,color: Colors.white),
                  )
              ),
              new SizedBox(height:100.0),
          Container(
            width:500.0,
            child:TextField(
              controller: _textemail,
              onSubmitted: _logemail,
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
                  onSubmitted: _logemail,
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
                      onPressed: () {
                        _logemail(_textemail.text).then((User user) {
                          print(user.displayName);
                          Navigator.pop(context);
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new Menu(name:user.displayName)));
                        }).catchError((e) => print(e));
                      },
                      child: const Text("Sign in", style: TextStyle(fontSize: 40,color: Colors.black)),
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
              SizedBox(height: 80.0,),
              new Container(
                child:ButtonTheme(
                    height: 80.0,
                    minWidth: 500.0,
                    buttonColor: Colors.orangeAccent,
                    child:RaisedButton(
                      onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new signup()));
                      },
                      child: const Text("Create a new account", style: TextStyle(fontSize: 40,color: Colors.black)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    )
                ),
              ),
            ]
        )
      ),
    );
  }
}