import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CrudMethods{
  Future<void> addData(payDetail,collectionDetail) async{
      await Firestore.instance.collection(collectionDetail).add(payDetail).catchError((e){
        print(e);
      });
  }
  getData(String dataDetail) async{
    return await Firestore.instance.collection(dataDetail).getDocuments();
  }
}