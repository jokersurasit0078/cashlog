// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late double userId;
  late String username;
  late String password;

  UserModel(double userId, String username, String password) {
    this.userId = userId;
    this.username = username;
    this.password = password;
  }

  CollectionReference chat = FirebaseFirestore.instance.collection('Chat');
  Future<void> addChat() async {
    await chat
        .add({
          'userId': this.userId,
          'username': this.username,
          'password': this.password,
        })
        .then((value) => print("Chat Added"))
        .catchError((error) => print("Failed to add Chat: $error"));
  }
  // Future<void> updateCondo() async {
  //   condo.doc(this.docId).update({
  //     'con_name' : this.condoName,
  //     'con_promptpay' : this.condoPromptpay,
  //     'con_rate': this.condoRate,
  //   })
  //   .then((value) => print("Condo Updated"))
  //   .catchError((error) => print("Failed to update Condo: $error"));
  // }
  // Future<void> deleteCondo() async {
  //   condo.doc(this.docId).delete()
  //   .then((value) => print("User Deleted"))
  //   .catchError((error) => print("Failed to delete Condo: $error"));
  // }
}
