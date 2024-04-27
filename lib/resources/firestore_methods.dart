import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_mate/resources/storage_methos.dart';
import 'package:uuid/uuid.dart';
FirebaseFirestore _firestore = FirebaseFirestore.instance;
class FirestoreMethos {

  Future<String> addpill({
    required String pillname,
    required String pilltype,
    required String pillamount,
    required String startdate,
    required String enddate,
    required String timming,
     Uint8List? file,
    required int notificationuid,
    required bool isimage,

  })async{
    String res = "error ocurred try again";
    try{
    var uid =Uuid().v1().substring(0, 6);
    String? photoUrl;
    if(isimage){
     photoUrl= await StorageMethods().uploadImageToStorage('profilePics', file!);
    }
      await _firestore.collection('admin').doc(FirebaseAuth.instance.currentUser!.uid).collection('pills').doc(uid).set({
        'uid': uid,
        'pillname':pillname,
        'pilltype':pilltype,
        'pillamount':pillamount,
        'startdate':startdate,
        'enddate':enddate,
        'timming':timming,
        'noteuid':notificationuid,
        'pillimage':photoUrl

      }).onError((error, stackTrace) => res="error ocurred try again");
      res= 'success';
      return res;
    }
    catch(e){
      return res;
    }
  }

  Future<String> delete(String docid) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('admin').doc(FirebaseAuth.instance.currentUser!.uid).collection('pills').doc(docid).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}
