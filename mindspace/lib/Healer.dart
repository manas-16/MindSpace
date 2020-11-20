import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:mindspace/Home.dart';

class Healer extends StatelessWidget {
  Healer({this.name});
  final name;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'AI Chat Bot',
      theme: ThemeData.dark(),/*new ThemeData(
        primaryColor: Colors.deepOrange,
      ),*/
      debugShowCheckedModeBanner: false,
      home: new HomePageDialogflow(name:name),
    );
  }
}

class HomePageDialogflow extends StatefulWidget {
  //HomePageDialogflow({Key key, this.title}) : super(key: key);
  HomePageDialogflow({this.name});
  final name;
  //final String title;

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow(name:name);
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  _HomePageDialogflow({this.name});
  final name;
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  final List<String> mess = ["How was your day?","tell me more","That sounds amazing","I am good! thanks for asking."];
  int k = 0;
  String chat="";



  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),

      child: new Container(
        height: 100.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
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

  void show1() async
  {
    Random rnd = new Random();
    int num = 1000 + rnd.nextInt(10000 - 1000);
    String url = "http://10.0.2.2:8000/rest/";
    Map dict = {'csrfmiddlewaretoken':'9aW3PExKej3GIOjd8M3XtlPwwtHnpWNxm4MKAg9NNICKM2FZoTVtSmE7l3ULmYlI',
      "name": "Manas",
      "sentiment": "neutral",
      "anger": 0.0,
      "sad": 0.0,
      "fear": 0.0,
      "happy": 0.0,
      "disgust": 0.0,
      "surprise": 0.0,
      "neutral": 0.0,
      "chat": chat,
      "unique":"ABCDE"+num.toString()};
    print(chat);
    http.Response sent = await http.post(url, headers: <String, String>{'Content-type':'application/json'}, body: jsonEncode(dict),);
    print(dict);
    Map value = json.decode(sent.body);
    print(value["id"]);
    String id = value["id"].toString();
    http.Response return_object = await http.get(url+id+"/");
    print(return_object.body);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style:TextStyle(fontSize: 50.0)),
        content: new Text('Do you want to quit',style:TextStyle(fontSize: 40.0)),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style:TextStyle(fontSize: 30.0)),
          ),
          new FlatButton(
            onPressed: () {
              show1();
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new Menu(name: name,))
              );
            },
            child: new Text('Yes',style:TextStyle(fontSize: 30.0)),
          ),
        ],
      ),
    )) ?? false;
  }

  void response(query,i) async {
    _textController.clear();
    /*AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/credentials.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,*/
    ChatMessage message = new ChatMessage(
      text:mess[i],
      name: "Healer",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
    k = k+1;
    chat = chat+" "+query;
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    if(text!=null){
      ChatMessage message = new ChatMessage(
        text: text,
        name: name,
        type: true,
      );
      setState(() {
        _messages.insert(0, message);
      });
    }
    Random rnd = new Random();
    // Define min and max value
    int min = 0, max = 4;
    //Getting range
    int num = min + rnd.nextInt(max - min);
    response(text,num);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child:new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            toolbarHeight: 100.0,
            title: new Text("AI Therapist Chatbot",style: TextStyle(fontSize: 40.0,)),
          ),
          body: new Column(children: <Widget>[
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
          ]),
    )
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(

        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child:Image.asset('Assets/bot1.png'),radius:50.0,backgroundColor: Colors.transparent,),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color:Colors.amberAccent,
                )),
            new Container(
              width:380.0,
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30.0,),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color:Colors.lightBlueAccent[100],)),//style: Theme.of(context).textTheme.subtitle1),
            new Container(
              width: 380.0,
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text,style: TextStyle(fontSize: 30.0,),textAlign: TextAlign.right,),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(child:Image.asset('Assets/user1.png'),radius:50.0,backgroundColor: Colors.transparent,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) :super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: TextStyle(fontSize: 40.0),),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Home Page"),
        ),
        body: new Center(
          child: new Text("Home Page"),
        ),
      ),
    );
  }
}