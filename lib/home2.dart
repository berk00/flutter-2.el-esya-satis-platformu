import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proje/home.dart';
import 'package:proje/storage2.dart';
import 'storage2.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'status_service.dart';

import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({key}) : super(key: key);

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
  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  var profileImage;

  kayitOl() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text);
  }

  void _kod() {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    CollectionReference StatusRef =
        FirebaseFirestore.instance.collection('urunler');

    StatusRef.add({
      'aciklama': t2.text,
      'baslik': t1.text,
      'image':
          "https://firebasestorage.googleapis.com/v0/b/fir-proje-dbd81.appspot.com/o/236.png?alt=media&token=d91f3c30-0d70-4777-b837-accede689af3"
    });
  }

  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 55,
                width: 165,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              /*Container(
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
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.all(1),
                height: 55,
                width: 165,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(1),
                height: 100,
                width: 100,
              ),*/
              /* IconButton(
                icon: Icon(Icons.play_arrow),
                color: Color.fromARGB(255, 0, 0, 0),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                iconSize: 50,
              ),*/

              Container(
                alignment: Alignment.topLeft,
                height: 20,
                width: 100,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ürün Başlığı",
                ),
                controller: t1,
              ),
              SizedBox(
                width: 50,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Ürün Hakkında Açıklama",
                ),
                controller: t2,
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 30,
                width: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Ürün Eklendi",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  _kod();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Ürün Ekle"),
              ),
              Container(
                alignment: Alignment.topLeft,
              ),
              IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                color: Color.fromARGB(255, 0, 0, 0),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                iconSize: 30,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(50),
                margin: EdgeInsets.all(1),
                height: 100,
                width: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () => _onImageButtonPressed(ImageSource.camera,
                          context: context),
                      child: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                      onTap: () => _onImageButtonPressed(ImageSource.gallery,
                          context: context),
                      child: Icon(
                        Icons.image,
                        size: 30,
                        color: Colors.blue,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dosya Seçilmedi'),
                          ),
                        );
                        return null;
                      }
                      final path = result.files.single.path!;
                      final fileName = result.files.single.name;
                      /* print(path);
                      print(fileName);*/

                      storage
                          .uploadFile(path, fileName)
                          .then((value) => print('Done'));

                      /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));*/
                    },
                    child: Text("Dosya Yükle"),
                  ),
                ],
              ),
              /*  Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );
                      if (result == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dosya Seçilmedi'),
                          ),
                        );
                        return null;
                      }
                      final path = result.files.single.path!;
                      final fileName = result.files.single.name;
                      /* print(path);
                      print(fileName);*/

                      storage
                          .uploadFile(path, fileName)
                          .then((value) => print('Done'));

                      /*Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));*/
                    },
                    child: Text("Dosya Yükle"),
                  ),
                  // ElevatedButton(onPressed: kayitOl, child: Text("Kayıt Ol")),
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        profileImage = pickedFile!;
        print("dosyaya geldim: $profileImage");
        if (profileImage != null) {}
      });
      print('aaa');
    } catch (e) {
      setState(() {
        _pickImage = e;
        print("Image Error: " + _pickImage);
      });
    }
  }
}
