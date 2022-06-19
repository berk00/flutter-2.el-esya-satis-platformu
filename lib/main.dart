import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "İkinci El",
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 203, 253),
      body: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  kayitOl() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text);
  }

  void _kod() {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    CollectionReference StatusRef =
        FirebaseFirestore.instance.collection('Status');

    StatusRef.add({'aciklama': "aa"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(50),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.all(50),
                height: 55,
                width: 165,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.all(1),
                height: 55,
                width: 165,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.all(1),
                height: 100,
                width: 100,
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                color: Color.fromARGB(255, 0, 0, 0),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                iconSize: 50,
              ),
              /* TextField(
                decoration: InputDecoration(
                  hintText: "e-posta giriniz...",
                ),
                controller: t1,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "parola giriniz...",
                ),
                controller: t2,
              ),*/
              /*Row(
                children: [
                  // ElevatedButton(onPressed: kayitOl, child: Text("Kayıt Ol")),
                  ElevatedButton(
                    onPressed: () {
                      _kod();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Login"),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
