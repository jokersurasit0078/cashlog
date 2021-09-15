import 'package:cashlog/constant.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class SaveLogModel {
  late String docId;
  late String date;
  late String time;
  late String detail;
  late String type;
  late double amount;
  late String monthYear;
  late List<String> transactionDayData;
  late List<String> amountDayData;
  late List<String> amountMonthData;

  SaveLogModel(
    String date,
    String time,
    String detail,
    String type,
    double amount,
    String monthYear,
    List<String> transactionDayData,
    List<String> amountDayData,
    List<String> amountMonthData,
  ) {
    this.date = date;
    this.time = time;
    this.detail = detail;
    this.type = type;
    this.amount = amount;
    this.monthYear = monthYear;
    this.transactionDayData = transactionDayData;
    this.amountDayData = amountDayData;
    this.amountMonthData = amountMonthData;
  }

  SaveLogModel.del(
    String docId,
    String type,
    double amount,
    String monthYear,
    List<String> transactionDayData,
    List<String> amountDayData,
    List<String> amountMonthData,
  ) {
    this.docId = docId;
    this.type = type;
    this.amount = amount;
    this.monthYear = monthYear;
    this.transactionDayData = transactionDayData;
    this.amountDayData = amountDayData;
    this.amountMonthData = amountMonthData;
  }

  var constant = new Constant();
  CollectionReference saveLog = FirebaseFirestore.instance.collection('saveLog');
  CollectionReference totalTransactionDay = FirebaseFirestore.instance.collection('TotalTransactionsDay');
  CollectionReference totalAmountDay = FirebaseFirestore.instance.collection('TotalAmountDay');
  CollectionReference totalAmountMonth = FirebaseFirestore.instance.collection('TotalAmountMonth');
  

  Future<void> addSaveLog() async {
    await saveLog
      .add({
        'date': this.date,
        'time': this.time,
        'detail': this.detail,
        'type': this.type,
        'amount': this.amount,
      })
      .then((value) => print("saveLog Added"))
      .catchError((error) => print("Failed to add saveLog: $error"));

    await totalTransactionDay.doc(transactionDayData[0]).update({
      'amount' : double.parse(transactionDayData[1])+1
    })
    .then((value) => print("transactionDayData Updated"))
    .catchError((error) => print("Failed to update transactionDayData: $error"));

    await totalAmountDay.doc(amountDayData[0]).update({
      'amount' : this.type == 'received' ? 
        double.parse(amountDayData[1])+this.amount 
        : double.parse(amountDayData[1])-this.amount
    })
    .then((value) => print("amountDayData Updated"))
    .catchError((error) => print("Failed to update amountDayData: $error"));

    await totalAmountMonth.doc(amountMonthData[0]).update({
      'amount' : this.type == 'received' ? 
        double.parse(amountMonthData[1])+this.amount 
        : double.parse(amountMonthData[1])-this.amount
    })
    .then((value) => print("amountMonthData Updated"))
    .catchError((error) => print("Failed to update amountMonthData: $error"));
  }
  Future<void> deleteSaveLog() async {
    await saveLog.doc(this.docId)
      .delete()
      .then((value) => print("saveLog Deleted"))
      .catchError((error) => print("Failed to delete saveLog: $error"));

    await totalTransactionDay.doc(transactionDayData[0]).update({
      'amount' : double.parse(transactionDayData[1])-1
    })
    .then((value) => print("transactionDayData Updated"))
    .catchError((error) => print("Failed to update transactionDayData: $error"));

    await totalAmountDay.doc(amountDayData[0]).update({
      'amount' : this.type == 'received' ? 
        double.parse(amountDayData[1])-this.amount 
        : double.parse(amountDayData[1])+this.amount
    })
    .then((value) => print("amountDayData Updated"))
    .catchError((error) => print("Failed to update amountDayData: $error"));

    await totalAmountMonth.doc(amountMonthData[0]).update({
      'amount' : this.type == 'received' ? 
        double.parse(amountMonthData[1])-this.amount 
        : double.parse(amountMonthData[1])+this.amount
    })
    .then((value) => print("amountMonthData Updated"))
    .catchError((error) => print("Failed to update amountMonthData: $error"));
  }
  // Future<void> updateCondo() async {
    // condo.doc(this.docId).update({
    //   'con_name' : this.condoName,
    //   'con_promptpay' : this.condoPromptpay,
    //   'con_rate': this.condoRate,
    // })
    // .then((value) => print("Condo Updated"))
    // .catchError((error) => print("Failed to update Condo: $error"));
  // }
  // Future<void> deleteCondo() async {
  //   condo.doc(this.docId).delete()
  //   .then((value) => print("User Deleted"))
  //   .catchError((error) => print("Failed to delete Condo: $error"));
  // }
}
