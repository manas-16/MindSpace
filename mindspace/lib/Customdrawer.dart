import 'dart:convert';
import 'package:mindspace/Profile.dart';
import 'package:mindspace/Reports.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mindspace/Healer.dart';
import 'package:mindspace/Home.dart';
import 'package:mindspace/groupchat.dart';
import 'package:mindspace/Moodify.dart';
import 'package:mindspace/stress-test.dart';
import 'package:mindspace/login.dart';
import 'package:mindspace/about.dart';



class customdraw extends StatelessWidget {
  customdraw({this.name});
  final name;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 450.0,
      color: Colors.grey[850],
      child: Column(
          children: <Widget>[
            new SizedBox(
              height: 80.0,
            ),
            Text("Hello "+name+"!", style: TextStyle(fontSize: 50,color: Colors.white)),
            Divider(
              color: Colors.grey[500],
              height: 100.0,
              thickness: 4.0,
              indent: 20.0,
              endIndent: 20.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new Healer(name: name,))
                  );
                },
                child: const Text("AI Therapist Chatbot", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new letstalk(name:name))
                  );
                },
                child: const Text("Online Rehab Community", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new mood(name:name))
                  );
                },
                child: const Text("Moodify", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new rMenu(name:name))
                  );
                },
                child: const Text("Reports", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new pMenu(name:name))
                  );
                },
                child: const Text("Edit Profile", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new log())
                  );
                },
                child: const Text("Log Out", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),
            Divider(
              color: Colors.grey[400],
              height: 40.0,
              thickness: 3.0,
              indent: 40.0,
              endIndent: 40.0,
            ),
            ButtonTheme(
              minWidth: 410.0,
              child:FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new about())
                  );
                },
                child: const Text("About Us", style: TextStyle(fontSize: 30,color: Colors.white)),
              ),
            ),

          ]
      ),
    );
  }
}
