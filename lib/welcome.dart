import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'model/user.dart';

class Welcome extends StatefulWidget {
  //variable
  int userID;

  //constructor
  Welcome({Key key, @required this.userID}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState(userID);
}

class _WelcomeState extends State<Welcome> {
  //variables
  DatabaseHelper helper = DatabaseHelper();
  int userID;
  User user;
  Future userFuture;

  //constructor
  _WelcomeState(this.userID);

  @override
  void initState() {
    super.initState();
    userFuture = _getUser(userID);
  }

  _getUser(userID) async {
    print('user $userID');
    user = await helper.getCurrentUser(userID);
    print(user.name);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: FutureBuilder(
        //displays data of type Future
        future: userFuture,
        builder: (context, snapshot) {
          Widget text;
          if (snapshot.connectionState == ConnectionState.done) {
            return text = Text(user.name);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
