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

  List<String> keyList;

  String SelectedUniversity;

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

      keyList =
          jsonDecode(response.body.toString()).keys.toList() as List<String>;

      print(keyList);
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
              DropdownButton<String>(
                value: null,
                items: keyList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),

                onChanged: (_value) {
                  //valueChanged(_value);
                  print(_value);
                  print(keyList);
                  keyList = null;

                  Text(
                    '_value',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );

                  setState(() {
                    if (SelectedUniversity != 'Get the Data First') {
                      SelectedUniversity = _value;
                    }
                    print(SelectedUniversity);
//                  Text(
//                    selectUniversity,
//                    textAlign: TextAlign.center,
//                    style: TextStyle(color: Colors.white),
//                  );
                  });
                },

//                  style: TextStyle(
//                    color: Colors.white,
//                  ),
                hint: Text(
                  'Select Universities',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        collegeDataLenght == null ? 0 : collegeDataLenght,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        height: 110,
                        child: Card(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: CircleAvatar(
                                  radius: 45.0,
                                  backgroundColor: Colors.red,
                                  backgroundImage:
                                      data[SelectedUniversity.toString()][index]
                                                  ['avatarImage'] ==
                                              'url'
                                          ? AssetImage('images/url.jpg')
                                          : null,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                data[SelectedUniversity.toString()][index]
                                        ['teacherName']
                                    .toString(),
                                style: TextStyle(
                                  //fontFamily: 'Pacifico',
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

class DipGridView extends StatelessWidget {
  const DipGridView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
                    backgroundColor: Colors.black12,
                    backgroundImage: teachersInfo[index]['avatarImage'] == 'url'
                        ? AssetImage('images/url.jpg')
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
    );
  }
}
