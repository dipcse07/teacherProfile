import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher\s Profile',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Teacher\s Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int count = 0;
List teachersInfo = [];

class _MyHomePageState extends State<MyHomePage> {
  var data;

  var collegeDataLenght;

//  @override
//  void initState() {
//    this.getData();
//  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://my-json-server.typicode.com/dipcse07/demoJSON/db"),
        headers: {"Accept": "application/json"});

    //print(response.body);
    print('tapped');

    setState(() {
      data = jsonDecode(response.body.toString());

      collegeDataLenght = data['CollegeName1'].length;
      count = collegeDataLenght;
      teachersInfo = data['CollegeName1'];
      print(teachersInfo[0]['avatarImage']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        //body: List.generate(length, generator)
        body: Container(
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  getData();

                  print('the count: $count');
                },
                child: Text('get data'),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  children: List.generate(count, (index) {
                    return Center(
                      child: Container(
//                        height: 180,
//                        width: 180,
                        //margin: EdgeInsets.all(1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 9.0),
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundColor: Colors.red,
                                backgroundImage:
                                    teachersInfo[index]['avatarImage'] == 'url'
                                        ? AssetImage('images/dip.jpg')
                                        : null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                teachersInfo[index]['teacherName'].toString(),
                                style: TextStyle(
                                  fontFamily: 'Pacifico',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

//ListView.builder(
//itemCount: data == null ? 0 : data['CollegeName1'].length,
//itemBuilder: (BuildContext context, int index) {
//return Card(
//child: Column(
//children: <Widget>[
//Text(data['CollegeName1'][index]['teacherName'] == null
//? 'text'
//    : data['CollegeName1'][index]['teacherName']),
//],
//),
//);
//},
