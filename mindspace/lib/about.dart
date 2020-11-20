import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';


class about extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'about',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: new aboutus(),
    );
  }
}

class aboutus extends StatefulWidget {
  aboutus({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _aboutus createState() => new _aboutus();
}

class _aboutus extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(200.0, 20.0, 200.0, 20.0),
                child:Text("Developed By \nManas Khare",
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                )
            )
          ],
        )
    );
  }
}