import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'input_text_field.dart';
import 'model/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DatabaseHelper helper = DatabaseHelper();
  var name, pw;
  int idCurrentUser;
  User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Willkommen',
                style: TextStyle(
                  color: Colors.teal[900],
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Column(
                children: [
                  InputTextField(
                    label: 'Spielername',
                    onChange: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  InputTextField(
                    label: 'Passwort',
                    password: true,
                    onChange: (value) {
                      pw = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Passwort Vergessen?',
                      style: TextStyle(color: Colors.teal[800]),
                    ),
                  ),
                  //Login Button
                  SizedBox(
                    height: 60,
                  ),
                  //LoginButton(),
                  //Keinen Account/ Register
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      color: Colors.teal[700],
                      onPressed: () async {
                        await setState(() {
                          debugPrint("Save button clicked");
                          _save();
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      color: Colors.teal[700],
                      onPressed: () async {
                        await setState(() {
                          debugPrint("getUser");
                          _getUser();
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Get User',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),
            // Passwort Vergessen
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(text: 'Keinen Account?  '),
                    TextSpan(
                        text: 'Neu Anmelden',
                        style: TextStyle(
                          color: Colors.teal[900],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<int> _save() async {
    //TODO Check if already exists _showAlaertDialog('Nutzername oder Passwort ist falsch!'
    idCurrentUser = await helper.insertUser(name, pw);
    print(idCurrentUser);
    return idCurrentUser;
  }

  Future<User> _getUser() async {
    print('user $idCurrentUser');
    user = await helper.getCurrentUser(idCurrentUser);
    print(user.name);
    return user;
  }

/*
  Future _save() async {
    //TODO Check if already exists _showAlaertDialog('Nutzername oder Passwort ist falsch!'
    await helper.insertUser(name, pw);
  }
  */

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.amber[50],
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Login',
        style: TextStyle(
          color: Colors.teal[900],
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.teal[900],
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
