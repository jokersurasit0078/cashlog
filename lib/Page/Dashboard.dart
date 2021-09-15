import 'package:cashlog/Model/totalAmountDayModel.dart';
import 'package:cashlog/Model/totalAmountMonthModel.dart';
import 'package:cashlog/Model/totalTransactionDayModel.dart';
import 'package:cashlog/Widgets/Appbar/AppbarWithRightIcon.dart';
import 'package:cashlog/Widgets/LoadingSnapshot.dart';
import 'package:cashlog/Widgets/TextTitle.dart';
import 'package:cashlog/constant.dart';
import 'package:cashlog/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';
import 'package:cashlog/Widgets/Drawer.dart';
import 'package:cashlog/Widgets/CardTotal.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double screenWidth, screenHeight;
  var themeColor = new ColorSet();
  var constant = new Constant();
  var routes = Routes();

  late var totalTransactionDayModel = new TotalTransactionDayModel.addNewDate(constant.thisDate);
  late var totalAmountDayModel = new TotalAmountDayModel.addNewDate(constant.thisDate);
  late var totalAmountMonthModel = new TotalAmountMonthModel.addNewDate(constant.thisMonthYear);

  void initState(){
    super.initState();
    getTotalTransactionDay(constant.thisDate).then((result) {
      if(result == 0){
        totalTransactionDayModel.addNewTotalTransaction();
      }
    });
    getTotalAmountDay(constant.thisDate).then((result) {
      if(result == 0){
        totalAmountDayModel.addNewTotalAmount();
      }
    });
    getTotalAmountMonth(constant.thisMonthYear).then((result) {
      if(result == 0){
        totalAmountMonthModel.addNewTotalAmount();
      }
    });
  }

  late Query saveLog = FirebaseFirestore.instance
    .collection('saveLog')
    .where('date', isEqualTo: constant.thisDate);
  
    
  late Query totalTransactionsDay = FirebaseFirestore.instance
    .collection('TotalTransactionsDay')
    .where('date', isEqualTo: constant.thisDate);
  late Query totalAmountDay = FirebaseFirestore.instance
    .collection('TotalAmountDay')
    .where('date', isEqualTo: constant.thisDate);
  late Query totalAmountMonth = FirebaseFirestore.instance
    .collection('TotalAmountMonth')
    .where('date', isEqualTo: constant.thisMonthYear);


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      appBar: appbarWithRightIcon(context, 'แดชบอร์ด', () => onClickRightIcon(), Icon(Icons.add)),
      drawer: drawer(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [textTitle('ยินดีต้อนรับสู่ Cash-Log (${constant.thisDate})', constant.textTitle, FontWeight.bold)]
              ),
              SizedBox(height: 15),

              if(screenWidth<1300)
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: totalTransactionsDay.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "จำนวนรายการทั้งหมด-วันนี้", themeColor.greenLight, themeColor.greenDark, '${document.data()['amount'].toString()} รายการ');
                          }).toList(),
                        );
                      }
                    ),
                    SizedBox(height: 15),
                    StreamBuilder<QuerySnapshot>(
                      stream: totalAmountDay.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "ยอดเงินรวม-วันนี้", themeColor.redLight, themeColor.redDark, '${document.data()['amount'].toString()} \$');
                          }).toList(),
                        );
                      }
                    ),
                    SizedBox(height: 15),
                    StreamBuilder<QuerySnapshot>(
                      stream: totalAmountMonth.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "ยอดเงินรวม-เดือนนี้", themeColor.blueLight, themeColor.blueDark, '${document.data()['amount'].toString()} \$');
                          }).toList(),
                        );
                      }
                    ),
                    SizedBox(height: 15),
                  ]
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: totalTransactionsDay.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "จำนวนรายการทั้งหมด-วันนี้", themeColor.greenLight, themeColor.greenDark, '${document.data()['amount'].toString()} รายการ');
                          }).toList(),
                        );
                      }
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: totalAmountDay.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "ยอดเงินรวม-วันนี้", themeColor.redLight, themeColor.redDark, '${document.data()['amount'].toString()} \$');
                          }).toList(),
                        );
                      }
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: totalAmountMonth.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else if (snapshot.connectionState == ConnectionState.waiting) {
                          return loadingSnapshot(CircularProgressIndicator());
                        }
                        else return Column(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            return cardTotal(screenWidth, "ยอดเงินรวม-เดือนนี้", themeColor.blueLight, themeColor.blueDark, '${document.data()['amount'].toString()} \$');
                          }).toList(),
                        );
                      }
                    ),
                  ]
                ),

              StreamBuilder<QuerySnapshot>(
                stream: saveLog.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return loadingSnapshot(textTitle('ไม่พบรายการในวันนี้', constant.textDetail, FontWeight.w400));
                  }
                  else if (snapshot.connectionState == ConnectionState.waiting) {
                    return loadingSnapshot(CircularProgressIndicator());
                  }
                  else {
                    if(snapshot.data!.docs.length == 0)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 15),
                          textTitle('ไม่พบรายการในวันนี้', 18, FontWeight.w400)
                        ],
                      );
                    else{
                      return Column(
                        children: [
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  return cardLog(document);
                                }).toList()
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ],
                      );
                    }
                  }
                }
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget cardLog(DocumentSnapshot document) {
    return Container(
      width: screenWidth*0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 1, color: Color.fromARGB(255, 191, 191, 191))
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1.0,
                  color: Color.fromARGB(255, 191, 191, 191)
                )
              )
            ),
            child: Icon(
              // Icons.account_circle_sharp,
              document.data()['type'] == 'received' ? Icons.account_balance_wallet  : Icons.money_off_sharp,
              color: document.data()['type'] == 'received' ? themeColor.greenDark : themeColor.redLight,
              size: 40
            ), // Hardcoded to be 'x'
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${document.data()['detail']}',
                style: (TextStyle(fontFamily: 'Prompt', fontSize: constant.textDetail))
              ),
            ],
          ),
          subtitle: Text(
            '${document.data()['date']} | ${document.data()['time']}',
            style: (TextStyle(fontFamily: 'Prompt', fontSize: constant.textSubDetail))
          ),
          trailing: Wrap(
            children: [
              Text(
                document.data()['type'] == 'received' ? '+${document.data()['amount']} \$' : '-${document.data()['amount']} \$',
                style: (TextStyle(fontFamily: 'Prompt', fontSize: constant.textSubTitle, fontWeight: FontWeight.bold))
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future getTotalTransactionDay(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalTransactionsDay')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }
  Future getTotalAmountDay(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalAmountDay')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }
  Future getTotalAmountMonth(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalAmountMonth')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }
  onClickRightIcon(){
    Navigator.pushNamed(context, routes.addTransactions['name']);
  }
}
