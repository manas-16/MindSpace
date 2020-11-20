import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';




class letstalk extends StatelessWidget {
  letstalk({this.name});
  final name;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Let's Talk",
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new groupchat(name:this.name),
    );
  }
}

class groupchat extends StatefulWidget {
  groupchat({Key key, this.title,this.name}) : super(key: key);
  final String title;
  final name;

  @override
  _groupchat createState() => new _groupchat(name: this.name);
}

class _groupchat extends State<groupchat> {
  _groupchat({this.name});
  final  name;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100.0,
        title: new Text("Online Rehab Community",style: TextStyle(fontSize: 40.0,)),
      ),
      body: new rehab(name:name),
    );
  }
}

class rehab extends StatefulWidget {
  rehab({Key key, this.title,this.name}) : super(key: key);
  final name;

  final String title;

  @override
  _rehab createState() => new _rehab(name:name);
}

class _rehab extends State<rehab> {
  _rehab({this.name});
  final  name;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  final firestoreinstance = FirebaseFirestore.instance;
  // var _firebaseRef = FirebaseDatabase().reference().child('Messages');

  final chatkey = "vWZHExiusDHTI9al5Fal";
  //final List<Map<String,dynamic>> mess= [];
  Stream documentStream;

/*  Future<dynamic> getData() async {

    final CollectionReference collect =   firestoreinstance.collection("Groupchat").doc(chatkey).collection("Message");

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        print(snapshot.data);
      });
    });
  }*/

  getData() async
  {
    _messages.clear();
    QuerySnapshot documentStream = await FirebaseFirestore.instance.collection("Groupchat").doc(chatkey).collection("Message").orderBy("current").get();
    //print(documentStream.docs.map((doc) => doc.data()));
    for(var element in documentStream.docs.map((doc) => doc.data()))
    {
      int t = name==element["name"]?1:0;
      setState(() {
        _messages.insert(0, ChatMessage(name: element["name"],
          text: element["text"],
          current: element["date-time"],
          type: t,
        ));
      });
    }
    //print(mess);
  }
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();

    //print(documentStream);
    getData();
  }



  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),

      child: new Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                style: new TextStyle(fontSize: 30.0,),
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message",hintStyle: new TextStyle(fontSize: 30.0,)),
              ),

            ),
            new Container(

              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  iconSize: 40.0,
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleSubmitted(String text) async {
    _textController.clear();
    if(text!=""){
      try
      {
        print(name);
        await firestoreinstance.collection("Groupchat").doc(chatkey).collection("Message").add({
          "name":name,
          "text":text,
          "date-time":DateFormat().add_Hm().format(DateTime.now()).toString()+" "+DateFormat().add_yMd().format(DateTime.now()).toString(),
          "current":DateTime.now()
        });
      }
      catch(e)
      {
        print(e);
      }

      getData();
      }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
            new Flexible(
                  child: new ListView.builder(
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                )),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ]
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type,this.current});

  final String text;
  final String name;
  final int type;
  final String current;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new SizedBox(width: 8.0,),
    new Expanded(
          child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                new Container(
                      constraints: BoxConstraints(minWidth: 100.0,maxWidth: 400.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: new Column(
                        children: <Widget>[
                            Padding(padding:EdgeInsets.fromLTRB(2.0, 3.0, 2.0, 0.0),child:Align(
                              alignment: Alignment.topLeft,
                              child:Text(name, style: TextStyle(fontSize: 25,color: Colors.black)),)),
                            SizedBox(height:5.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(text, style: TextStyle(fontSize: 40,color: Colors.black)),),
                            Align(
                                alignment: Alignment.bottomRight,
                                child:Text(current, style: TextStyle(fontSize: 20,color: Colors.black)))
                        ],
                      ),
                ),
            ]
        )
    )
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Container(
                  constraints: BoxConstraints(minWidth: 100.0,maxWidth: 400.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: new Column(
                    children: <Widget>[
                      Padding(padding:EdgeInsets.fromLTRB(2.0, 3.0, 2.0, 0.0),child:Align(
                        alignment: Alignment.topLeft,
                        child:Text(name, style: TextStyle(fontSize: 25,color: Colors.black)),)),
                      SizedBox(height:5.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(text, style: TextStyle(fontSize: 40,color: Colors.black)),),
                      Align(
                          alignment: Alignment.bottomRight,
                          child:Text(current, style: TextStyle(fontSize: 20,color: Colors.black)))
                    ],
                  ),
                ),
              ]
          )
      ),
      new SizedBox(width: 8.0,)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type==1 ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}


