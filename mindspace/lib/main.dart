import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mindspace/Healer.dart';
import 'package:mindspace/Home.dart';
import 'package:mindspace/Reports.dart';
import 'package:mindspace/Profile.dart';
import 'package:mindspace/login.dart';
import 'package:mindspace/signup.dart';
import 'package:firebase_core/firebase_core.dart';



void main()  {

  runApp(
      MaterialApp(
          title: 'Named Routes Demo',
          initialRoute: '/login',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/home': (context) => Menu(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/healer': (context) => new Healer(),
            '/profile': (context) => new pMenu(),
            '/reports': (context) => new rMenu(),
            '/moodify': (context) => new Healer(),
            '/letstalk': (context) => new Healer(),
            '/stresstest': (context) => new Healer(),
            '/login': (context) => new log(),
            '/signup': (context) => new sign(),
    },
  )
  );
}

