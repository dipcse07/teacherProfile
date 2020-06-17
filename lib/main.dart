import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:json_list_view/constant.dart';
import 'package:menu_button/menu_button.dart';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'dart:convert';
import 'result_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher\s Profile',
      theme: ThemeData.light(),
      home: MyHomePage(title: 'Teacher\'s Profile'),
    );
  }
}



 String selectedItem = 'Select University';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int count = 0;
List teachersInfo = [];

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();


  }

  var data;

  int collegeDataLenght;


  List<String> keyList = [];

  String SelectedUniversity;

//  @override
//  void initState() {
//    this.getData();



//  }




  Future<String> getData() async {
//    if (dataList != null ){
//
//
//        data = dataList;
//
//        keyList = ['CollegeName1','CollgeName2','CollegeName3','CollgeName4'] as List<String>; // as List<String>;
//        print(keyList);
//
//        var selItem = 'CollegeName1';
//        collegeDataLenght = data[selItem].length;
//
//
//
//    }
//    else {
      var response = await http.get(
          Uri.encodeFull(
              "https://my-json-server.typicode.com/dipcse07/demoJSON/db"),
          headers: {"Accept": "application/json"});

      //print(response.body);
      print('tapped');
      data = jsonDecode(response.body.toString());

      collegeDataLenght = data['CollegeName1'].length;
      count = collegeDataLenght;
      teachersInfo = data['CollegeName1'];
      print(teachersInfo[0]['avatarImage']);

      keyList =
      jsonDecode(response.body.toString()).keys.toList() as List<String>;
      setState(() {
        print(keyList);
      });
    //}
  }

  final Widget button = SizedBox(
    width: 83,
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(

            child: Text(
              selectedItem,
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )
              )
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        //body: List.generate(length, generator)
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              FlatButton(
//                onPressed: () {
//                  getData();
//
//                  print('the count: $count');
//                },
//                child: Text('get data'),
//              ),



              MenuButton(
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(

                          child: Text(
                            selectedItem,
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                            width: 12,
                            height: 17,
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                ),// Widget displayed as the button
                items: keyList,// List of your items

                topDivider: true,
                selectedItem: selectedItem,
               // popupHeight: 200, // This popupHeight is optional. The default height is the size of items
                scrollPhysics: AlwaysScrollableScrollPhysics(), // Change the physics of opened menu (example: you can remove or add scroll to menu)
                itemBuilder: (value) => Container(
                    width: 150,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(value)
                ),// Widget displayed for each item
                toggledChild: Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(

                            child: Text(
                              selectedItem,
                              style: TextStyle(color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                              width: 12,
                              height: 17,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  ),// Widget displayed as the button,
                ),
                divider: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onItemSelected: (value) {
                  setState(() {
                    selectedItem = value;
                    SelectedUniversity = selectedItem;
                    print('selected item: $SelectedUniversity');

                    print(data[selectedItem][0]['avatarImage']);
                  });

                  // Action when new item is selected
                },
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]),
                    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                    color: Colors.white
                ),
                onMenuButtonToggle: (isToggle) {
                  print(isToggle);
                },
              ),

//              DropdownButton<String>(
//                value: SelectedUniversity,
//                items: keyList.map((String value) {
//                  return DropdownMenuItem<String>(
//                    value: value,
//                    child: Text(value),
//                  );
//                }).toList(),
//                onChanged: (_value) {
//                  //valueChanged(_value);
//                  print(_value);
//                  print(keyList);
//                  setState(() {
//                    SelectedUniversity = _value;
//                  });
//
//                },
//                hint: Text(
//                  'Select Universities',
//                  style: TextStyle(
//                    //color: Colors.white,
//                    fontWeight: FontWeight.bold,
//                  ),
//                  textAlign: TextAlign.center,
//                ),
//              ),



              SelectedUniversity == null
                  ? SizedBox()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: collegeDataLenght == null ? 0 : collegeDataLenght,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultPage(
                                        teacherName:  data[SelectedUniversity.toString()]
                                        [index]['teacherName']
                                            .toString(),
                                        title:  data[SelectedUniversity.toString()]
                                        [index]['title']
                                            .toString(),
                                        avatarImage:  data[SelectedUniversity.toString()]
                                        [index]['avatarImage']
                                            .toString(),
                                        phone:  data[SelectedUniversity.toString()]
                                        [index]['phone']
                                            .toString(),
                                        email:  data[SelectedUniversity.toString()]
                                        [index]['email']
                                            .toString(),
                                        address:  data[SelectedUniversity.toString()]
                                        [index]['address']
                                            .toString(),

                                        teacherID:  data[SelectedUniversity.toString()]
                                        [index]['teacherID']
                                            .toString()),
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                height: 70,
                                child: Card(
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: CircleAvatar(
                                          radius: 28.0,
                                          backgroundColor: Colors.red,
                                          backgroundImage:
                                          AssetImage(

                                            data[
                                              SelectedUniversity]
                                              [index]['avatarImage'] != null? data[
                                              SelectedUniversity]
                                              [index]['avatarImage'].toString(): null

                                          ),

                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.0,
                                      ),
                                      AutoSizeText(
                                        data[SelectedUniversity.toString()]
                                                [index]['teacherName']
                                            .toString(),
                                        style: TextStyle(
                                          //fontFamily: 'Pacifico',
                                          fontSize: 20.0,
                                         // color: Colors.white,
                                          fontWeight: FontWeight.bold,

                                        ),
                                        minFontSize: 18,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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

