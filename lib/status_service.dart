import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'status.dart';
import 'package:image_picker/image_picker.dart';
import 'add_status.dart';
import 'storage_service.dart';

class StatusService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StorageService storageService = StorageService();
  String mediaUrl = "";

  //Ekleme İşlemi
  Future<Status> addStatus(
      String status, XFile pickedFile, String aciklama) async {
    var ref = firestore.collection("urunler");
    mediaUrl = await storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref
        .add({'status': status, 'image': mediaUrl, 'aciklama': aciklama});

    return Status(status: status, image: mediaUrl, aciklama: aciklama);
  }

  //Listeleme işlemi
  Stream<QuerySnapshot> getStatus() {
    var ref = firestore.collection("urunler").snapshots();

    return ref;
  }

  //Silme İşlemi
  Future<void> removeStatus(String docId) {
    var ref = firestore.collection("urunler").doc(docId).delete();

    return ref;
  }
}
