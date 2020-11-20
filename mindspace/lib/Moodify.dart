import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mindspace/Home.dart';


class mood extends StatelessWidget {
  mood({this.name});
  final name;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Moodify',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new moodify(name:this.name),
    );
  }
}

class moodify extends StatefulWidget {
  moodify({Key key, this.title,this.name}) : super(key: key);
  final String title;
  final name;

  @override
  _moodify createState() => new _moodify(name:this.name);
}

class _moodify extends State<moodify> {
  _moodify({this.name});
  final name;
  final TextEditingController _text = new TextEditingController();

  Future<String> show1(text) async
  {
    Random rnd = new Random();
    int num = 1000 + rnd.nextInt(10000 - 1000);
    String url = "http://10.0.2.2:8000/rest/";
    Map dict = {'csrfmiddlewaretoken':'9aW3PExKej3GIOjd8M3XtlPwwtHnpWNxm4MKAg9NNICKM2FZoTVtSmE7l3ULmYlI',
      "name": name,
      "sentiment": "neutral",
      "anger": 0.0,
      "sad": 0.0,
      "fear": 0.0,
      "happy": 0.0,
      "disgust": 0.0,
      "surprise": 0.0,
      "neutral": 0.0,
      "chat": text,
      "unique":"ABCDE"+num.toString()};
    print(text);
    http.Response sent = await http.post(url, headers: <String, String>{'Content-type':'application/json'}, body: jsonEncode(dict),);
    print(dict);
    Map value = json.decode(sent.body);
    print(value["id"]);
    String id = value["id"].toString();
    http.Response return_object = await http.get(url+id+"/");
    print(return_object.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100.0,
        title: new Text("Moodify",style: TextStyle(fontSize: 40.0,)),
      ),
      body:Center(
          child : Column(
              mainAxisAlignment:MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Describe your Day!",style: TextStyle(fontSize: 45.0,color: Colors.greenAccent)),
                SizedBox(height:50.0),
                Container(
                  width: 600.0,
                  child: Flexible(
                    child:TextField(
                      controller: _text,
                      maxLines: 15,
                      style: new TextStyle(fontSize: 30.0),
                      decoration: InputDecoration(
                        hintText: 'Type here!',
                        hintStyle: new TextStyle(fontSize: 30.0,),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  )
                ),
                SizedBox(height:50.0),
                new Container(
                  child:ButtonTheme(
                      height: 80.0,
                      minWidth: 200.0,
                      buttonColor: Colors.greenAccent,
                      child:RaisedButton(
                        onPressed: () {
                          show1(_text.text);
                          Navigator.pop(context);
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                              new Menu(name: name,))
                          );
                        },
                        child: const Text("Save", style: TextStyle(fontSize: 40,color: Colors.black)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      )
                  ),
                ),
              ]
          )
      )
    );
  }
}