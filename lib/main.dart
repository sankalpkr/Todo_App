import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Final Project',
      home:
      MyHomePage(title: 'TO DO APP',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _strikeThrough extends StatelessWidget{
  bool bool1;
  String text;
  _strikeThrough({this.bool1,this.text}):super();

  Widget _strikewidget(){
    if(bool1 == false){
      return Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.yellowAccent
        ),
      );
    }
    else{
      return Text(
        text,
        style: TextStyle(
          fontSize: 20,
          decoration: TextDecoration.lineThrough,
          color: Colors.white60,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context){
    return _strikewidget();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _list = [];
  List<bool> _bool = [];



  void _showDialogBox() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter New Task'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'Enter New Task'
              ),
              onSubmitted: (text) {
                setState(() {
                  _list.add(text);
                  _bool.add(false);
                });
                Navigator.of(context).pop();
                //print(text);
              },
            ),

            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
                // Navigator.pop(context);
              }, child: Text('Cancel'),),
            ],
          );
        }
    );
  }

  Widget _getItems() {
    return Column(
      children: [
        Expanded(
          flex:1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.orangeAccent,
                margin: EdgeInsets.all(10),
                child: Text("WELCOME!!",
                  style: TextStyle(
                    fontFamily: "Akaya_Telivigala",
                    color: Colors.brown.shade700,
                    fontSize: 30,
                  ),
                ),

              ),
              Container(
                color: Colors.orangeAccent,
                margin: EdgeInsets.all(10),
                child: Text("Click on '+' to Add a New Task",
                  style: TextStyle(
                    color: Colors.brown.shade700,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: EdgeInsets.all(15),
            color: Colors.red,
            child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Center(
                child: ListView.builder(itemBuilder: (context, index) {
                  if (index < _list.length) {
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                      return Center(
                        child: CheckboxListTile(
                          checkColor: Colors.lightGreenAccent,
                            value: _bool[index],
                            title: _strikeThrough(text: _list[index], bool1: _bool[index]),

                            onChanged: (bool value) {
                              setState((){
                                _bool[index] = value;
                              });
                            }
                        ),
                      );
                    } );
                  }
                },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
      backgroundColor: Colors.purple,
        title: Text(widget.title,
        style: TextStyle(
            color: Colors.lightGreenAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
      body: Center(

          child: _getItems()
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        focusElevation: 100,
        onPressed: () {
          _showDialogBox();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}