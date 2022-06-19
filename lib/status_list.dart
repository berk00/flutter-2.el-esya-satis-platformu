import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'status_service.dart';
import 'package:image_picker/image_picker.dart';

class StatusListPage extends StatefulWidget {
  @override
  _StatusListPageState createState() => _StatusListPageState();
}

class _StatusListPageState extends State<StatusListPage> {
  StatusService _statusService = StatusService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _statusService.getStatus(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: snaphot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snaphot.data!.docs[index];

                  Future<void> _showChoiseDialog(BuildContext context) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                "Satın Almak İster Misiniz?",
                                textAlign: TextAlign.center,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              content: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          _statusService
                                              .removeStatus(mypost.id);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Evet",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Vazgeç",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 107, 168),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  )));
                        });
                  }

                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: InkWell(
                      onTap: () {
                        _showChoiseDialog(context);
                      },
                      child: Container(
                        height: size.height * .5,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                              ),
                              Text(
                                "${mypost['baslik']}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${mypost['aciklama']}",
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(mypost['image']),
                                  radius: size.height * 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
      },
    );
  }
}
