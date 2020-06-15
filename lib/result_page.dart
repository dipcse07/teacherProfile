import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String teacherName;
  final String title;
  final String avatarImage;
  final String phone;
  final String email;
  final String address;
  final String teacherID;

  ResultPage(
      {@required this.teacherName,
      @required this.title,
      @required this.avatarImage,
      @required this.phone,
      @required this.email,
      @required this.address,
      @required this.teacherID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Teacher\'s Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
            width: 150.0,
          ),
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('images/$avatarImage.jpg'),
          ),
          SizedBox(
            height: 20,
            width: 150.0,
          ),
          Text(
            teacherName,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20.0,
              //color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              color: Colors.black54,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
            width: 150.0,
            child: Divider(
              color: Colors.black38,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                // color: Colors.teal,
              ),
              title: Text(
                phone,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20,
                  //color: Colors.teal.shade900,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.email,
                //color: Colors.teal,
              ),
              title: Text(
                email,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20,
                  //color: Colors.teal.shade900,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.home,
                //color: Colors.teal,
              ),
              title: Text(
                address,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20,
                  //color: Colors.teal.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
