import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class stressmeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Stress Test',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new stress(),
    );
  }
}

class stress extends StatefulWidget {
  stress({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _stress createState() => new _stress();
}

class _stress extends State<stress> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100.0,
        title: new Text("Stress Test",style: TextStyle(fontSize: 40.0,)),
      ),
    );
  }
}