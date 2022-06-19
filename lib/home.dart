import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home2.dart';
import 'status_list.dart';
import 'login.dart';
import 'auth_service.dart';
import 'add_status.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 0, 100, 167),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp2()));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          child: Icon(Icons.add),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Divider(),
              ListTile(
                title: Text('Çıkış yap'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                leading: Icon(Icons.remove_circle),
              ),
            ],
          ),
        ),
        body: StatusListPage());
  }
}
