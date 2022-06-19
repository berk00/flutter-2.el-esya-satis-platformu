import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String status;
  String image;
  String aciklama;

  Status({
    required this.status,
    required this.image,
    required this.aciklama,
  });
  /*void _kod() {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    CollectionReference StatusRef =
        FirebaseFirestore.instance.collection('Status');

    StatusRef.add({'aciklama': "aa"});
  }*/

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      status: snapshot["status"],
      image: snapshot["image"],
      aciklama: snapshot["aciklama"],
    );
  }
}
