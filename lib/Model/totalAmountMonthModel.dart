// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class TotalAmountMonthModel {
  late String docId;
  late String date;
  late double amount;

  TotalAmountMonthModel(String docId, String date) {
    this.docId = docId;
    this.date = date;
  }

  TotalAmountMonthModel.addNewDate(String date) {
    this.date = date;
  }

  CollectionReference totalAmountMonth = FirebaseFirestore.instance.collection('TotalAmountMonth');

  Future<void> addNewTotalAmount() async {
    totalAmountMonth
      .add({
        'date': this.date,
        'amount': 0,
      })
      .then((value) => print("add new month amount"))
      .catchError((error) => print("Failed to add new month amount: $error"));
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

