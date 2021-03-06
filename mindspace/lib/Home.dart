import 'dart:convert';
import 'package:mindspace/Moodify.dart';
import 'package:mindspace/Profile.dart';
import 'package:mindspace/Reports.dart';
import 'package:mindspace/groupchat.dart';
import 'package:mindspace/stress-test.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mindspace/Healer.dart';
import 'package:mindspace/Customdrawer.dart';
import 'package:firebase_core/firebase_core.dart';




class Menu extends StatelessWidget {
  Menu({this.name});
  final name;
  static const String _title = 'MINDSPACE';
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text(_title,style: TextStyle(fontSize: 40.0,),),
            centerTitle: true,
            backgroundColor: Colors.black,
            toolbarHeight: 100.0,
            leading: IconButton(
              icon: Icon(Icons.menu,size: 50.0,),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
          ),
          backgroundColor: Colors.grey[900],
          body: MyStatelessWidget(name:name),
          drawer: new customdraw(name: name,),
          bottomNavigationBar: new bbar(name:name),
        )
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key,this.name}) : super(key: key);
  final name;

  @override
  void initState() {
    Firebase.initializeApp();}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child:ButtonTheme(
                height: 200.0,
                minWidth: 600.0,
                buttonColor: Colors.greenAccent,
                child:RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new Healer(name:name))
                    );
                  },
                  child: const Text("AI Therapist Chatbot", style: TextStyle(fontSize: 40)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                )
            ),
          ),
          new SizedBox(
            height: 40.0,
          ),
          new Container(
            child:ButtonTheme(
                height: 200.0,
                minWidth: 600.0,
                buttonColor: Colors.amberAccent,
                child:RaisedButton(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new mood(name:name))
                    );
                  },
                  child: const Text("Moodify", style: TextStyle(fontSize: 40)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                )
            ),
          ),
          new SizedBox(
            height: 40.0,
          ),
          new Container(
            child:ButtonTheme(
                height: 200.0,
                minWidth: 600.0,
                buttonColor: Colors.pinkAccent,
                child:RaisedButton(
                  onPressed: () {
                    print(name);
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new letstalk(name:name))
                    );
                  },
                  child: const Text("Online Rehab Community", style: TextStyle(fontSize: 40)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                )
            ),
          ),

          new SizedBox(
            height: 20.0,
          ),
        ],
      ),

    );
  }
}



class bbar extends StatelessWidget {
  bbar({this.name});
  final name;
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.black26,
        height: 100.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 30.0),
          child:Row(
              children: <Widget>[
                IconButton(
                  color: Colors.grey[600],
                  icon: Icon(Icons.account_circle,size: 60.0,),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new pMenu(name:name))
                    );
                  },
                ),
                VerticalDivider(
                  color: Colors.grey[400],
                  width: 200.0,
                  thickness: 1.0,
                  indent: 10.0,
                ),
                 IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.home,size: 60.0,),
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new rMenu())
                      );
                    },
                  ),
                VerticalDivider(
                  color: Colors.grey[400],
                  width: 200.0,
                  thickness: 1.0,
                  indent: 10.0,
                ),
                IconButton(
                  color: Colors.grey[600],
                  icon: Icon(Icons.receipt,size: 60.0,),
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new rMenu(name:name))
                    );
                  },
                ),
              ]
          ),
        )
    );
  }
}

/*
new SizedBox(
            height: 20.0,
          ),
          new Container(
            child:ButtonTheme(
                height: 400.0,
                minWidth: 800.0,
                buttonColor: Colors.greenAccent,
                child:RaisedButton(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new Healer())
                    );
                  },
                  child: const Text("Healer", style: TextStyle(fontSize: 40)),
                )
            ),
            foregroundDecoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage('Assets/download.jpg'),fit: BoxFit.fill),
            ),
          ),
          new SizedBox(
            height: 30.0,
          ),
            new Container(
              child:ButtonTheme(
                  height: 400.0,
                  minWidth: 800.0,
                  buttonColor: Colors.lightBlueAccent,
                  child:RaisedButton(
                    onPressed: () {
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) =>
                          new Healer())
                      );
                    },
                    child: const Text("Let's Talk!", style: TextStyle(fontSize: 40)),
                  )
            ),
              foregroundDecoration: new BoxDecoration(

                image: new DecorationImage(image: new AssetImage('Assets/rehab12.jpg'),fit: BoxFit.fill),
              ),
            ),
          new SizedBox(
            height: 30.0,
          ),
          new Container(
            foregroundDecoration: new BoxDecoration(

                image: new DecorationImage(image: new AssetImage('Assets/em12.jpg'),fit: BoxFit.fill),
            ),
            child:ButtonTheme(
                height: 400.0,
                minWidth: 800.0,
                //buttonColor: Colors.orangeAccent,
                child:RaisedButton(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new Healer())
                    );
                  },
                  child: const Text("Reports", style: TextStyle(fontSize: 40)),
                )
            ),
            ),
          new SizedBox(
            height: 20.0,
          ),
*/

/*new Container(
                  child:ButtonTheme(
                    height: 200.0,
                    minWidth: 250.0,
                    buttonColor: Colors.pinkAccent,
                    child:RaisedButton(
                      onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                            new stressmeter())
                        );
                      },
                      child: const Text("Stress Test", style: TextStyle(fontSize: 40)),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                )*/