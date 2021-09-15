import 'package:cashlog/Model/saveLogModel.dart';
import 'package:cashlog/Model/totalAmountMonthModel.dart';
import 'package:cashlog/Widgets/Appbar/AppbarPop.dart';
import 'package:cashlog/Widgets/Button/ButtonIcon.dart';
import 'package:cashlog/Widgets/LoadingSnapshot.dart';
import 'package:cashlog/Widgets/TextField.dart';
import 'package:cashlog/Widgets/TextTitle.dart';
import 'package:cashlog/constant.dart';
import 'package:cashlog/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';
import 'package:cashlog/Model/totalAmountDayModel.dart';
import 'package:cashlog/Model/totalTransactionDayModel.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late double screenWidth, screenHeight;
  var themeColor = new ColorSet();
  var constant = new Constant();
  var routes = Routes();

  late List<String> dataTransactionDay = [];
  late List<String> dataAmountDay = [];
  late List<String>  dataAmountMonth = [];

  late var dateSelect = TextEditingController();
  late String dateSelectString = dateSelect.text.toString();
  late List<String> dateSplit = dateSelectString.split('/');  

  late bool isClickDelete = false;

  late bool typeReceived = true;
  late bool typePay = true;

  void initState(){
    super.initState();
    this.setState(() {
      dateSelect.text = constant.thisDate;
    });
    getDataTransactionDay(dateSelect.text).then((result) {
      print("Transaction Day : "+result.toString());
      this.setState(() {
        dataTransactionDay = result;
      });
    });
    getDataAmountDay(dateSelect.text).then((result) {
      print("Amount Day : "+result.toString());
      this.setState(() {
        dataAmountDay = result;
      });
    });
    getDataAmountMonth(constant.thisMonthYear).then((result) {
      print("Amount Month : "+result.toString());
      this.setState(() {
        dataAmountMonth = result;
      });
    });
  }

  late Query saveLog = FirebaseFirestore.instance
    .collection('saveLog')
    .where('date', isEqualTo: dateSelectString);
    // .limit(10);
    
  late Query totalTransactionsDay = FirebaseFirestore.instance
    .collection('TotalTransactionsDay')
    .where('date', isEqualTo: dateSelectString);
  late Query totalAmountDay = FirebaseFirestore.instance
    .collection('TotalAmountDay')
    .where('date', isEqualTo: dateSelectString);
  late Query totalAmountMonth = FirebaseFirestore.instance
    .collection('TotalAmountMonth')
    .where('date', isEqualTo: dateSplit[1]+'/'+dateSplit[2]);


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      appBar: appbarPop(context, 'ค้นหารายการ'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: screenWidth*0.1, right: screenWidth*0.1),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textTitle('เลือกวันที่ : ', constant.textTitle, FontWeight.bold),
                    textFieldDate(dateSelect, Icon(Icons.date_range_sharp), 250),
                    buttonIcon(context, () => onClickButtonDate(), null, Icons.date_range),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Container(
                width: screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dataTransactionDay.length > 0 ? Row(
                      children: [
                        textTitle('จำนวนรายการทั้งหมด-วันนี้ (${dateSelect.text}) : ', constant.textSubTitle, FontWeight.bold),
                        SizedBox(width: 20),
                        textTitle('${dataTransactionDay[1]}', constant.textTitle, FontWeight.bold),
                      ],
                    ) : CircularProgressIndicator(),
                    SizedBox(height: 10),
                    dataAmountDay.length > 0 ? Row(
                      children: [
                        textTitle('ยอดเงินรวม-วันนี้ (${dateSelect.text}) : ', constant.textSubTitle, FontWeight.bold),
                        SizedBox(width: 20),
                        textTitle('${dataAmountDay[1]} \$', 22, FontWeight.bold),
                      ],
                    ) : CircularProgressIndicator(),
                    SizedBox(height: 10),
                    dataAmountMonth.length > 0 ? Row(
                      children: [
                        textTitle('ยอดเงินรวม-เดือน (${dateSplit[1]+'/'+dateSplit[2]}) : ', constant.textSubTitle, FontWeight.bold),
                        SizedBox(width: 20),
                        textTitle('${dataAmountMonth[1]} \$', constant.textTitle, FontWeight.bold),
                      ],
                    ) : CircularProgressIndicator(),
                  ],
                )
              ),
              SizedBox(height: 20),

              Container(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textTitle('ฟิลเตอร์ : ',  constant.textSubTitle, FontWeight.bold),
                    SizedBox(width: 10),
                    textTitle('ได้รับ',  constant.textSubTitle, FontWeight.bold),
                    Checkbox(
                      value: typeReceived,
                      activeColor: themeColor.greenDark,
                      onChanged:(bool? newValue){
                        this.setState(() {
                          typeReceived = newValue!;
                        });
                      }
                    ),
                    textTitle('ใช้จ่าย',  constant.textSubTitle, FontWeight.bold),
                    Checkbox(
                      value: typePay,
                      activeColor: themeColor.greenDark,
                      onChanged:(bool? newValue){
                        this.setState(() {
                          typePay = newValue!;
                        });
                      }
                    )
                  ],
                )
              ),
              
              Container(
                width: screenWidth,
                constraints: BoxConstraints(minHeight: 100),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ) 
                  ]
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: saveLog.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return loadingSnapshot(textTitle('ไม่พบรายการในวันนี้',  constant.textSubTitle, FontWeight.w400));
                    }
                    else if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingSnapshot(CircularProgressIndicator());
                    }
                    else {
                      if(snapshot.data!.docs.length == 0)
                        return loadingSnapshot(textTitle('ไม่พบรายการในวันนี้',  constant.textSubTitle, FontWeight.w400));
                      else if(snapshot.data!.docs.length != 0 && (!typeReceived && !typePay)){
                        return loadingSnapshot(textTitle('กรุณาเลือกอย่างน้อย 1 ฟิลเตอร์',  constant.textSubTitle, FontWeight.w400));
                      }
                      else{
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    if(typeReceived && typePay){
                                      return textRowDetail(document);
                                    }
                                    else if(typeReceived && !typePay && document.data()['type'] == 'received'){
                                      return textRowDetail(document);
                                    }
                                    else if(!typeReceived && typePay && document.data()['type'] == 'pay'){
                                      return textRowDetail(document);
                                    }
                                    else{
                                      return SizedBox();
                                    }
                                  }).toList()
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            SizedBox(height: 10)
                          ],
                        );
                      }
                    }
                  }
                )
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget textRowDetail(DocumentSnapshot document) {
    return Container(
      child: Container(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              document.data()['type'] == 'received' ? Icons.account_balance_wallet  : Icons.money_off_sharp,
              color: document.data()['type'] == 'received' ? themeColor.greenDark : themeColor.redLight,
              size: 40
            ),
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
            style: (TextStyle(fontFamily: 'Prompt'))
          ),
          trailing: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              Text(
                document.data()['type'] == 'received' ? '+${document.data()['amount']} \$' : '-${document.data()['amount']} \$',
                style: (TextStyle(fontFamily: 'Prompt', fontSize: constant.textTitle, fontWeight: FontWeight.bold))
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: !isClickDelete ? Colors.redAccent : Colors.black87,
                hoverColor: Colors.black,
                onPressed: !isClickDelete ? () async {
                  this.setState(() {
                    isClickDelete = true;
                  });
                  var saveLogModel = SaveLogModel.del(
                    document.id,
                    document.data()['type'],
                    document.data()['amount'],
                    constant.thisMonthYear,
                    dataTransactionDay,
                    dataAmountDay,
                    dataAmountMonth,
                  );
                  await saveLogModel.deleteSaveLog();
                  this.setState(() {
                    isClickDelete = false;  
                  });
                  await getDataTransactionDay(this.dateSelectString).then((result) {
                    this.setState(() {
                      this.dataTransactionDay = result;
                    });
                  });
                  await getDataAmountDay(this.dateSelectString).then((result) {
                    this.setState(() {
                      this.dataAmountDay = result;
                    });
                  });
                  await getDataAmountMonth(this.dateSplit[1]+'/'+this.dateSplit[2]).then((result) {
                    this.setState(() {
                      this.dataAmountMonth = result;
                    });
                  });
                } : null
              ),
            ],
          ),
        ),
      ),
    );
  }
  onClickButtonDate() async {
    showDatePicker(
      context: context,
      initialDate: DateTime(int.parse(this.dateSplit[2]), int.parse(this.dateSplit[1]), int.parse(this.dateSplit[0])),
      firstDate: DateTime(2021, 7, 23),
      lastDate: DateTime.now(),
    )
      .then((date) async {
        late String dateFormatSelect = date!.toIso8601String();
        List<String> dateAndTimeSelect = dateFormatSelect.split('T');
        List<String> dateSplitSelect = dateAndTimeSelect[0].split('-');
        this.setState(() {
          this.dateSelect.text = '${dateSplitSelect[2]}/'+'${dateSplitSelect[1]}/'+'${dateSplitSelect[0]}';
          this.dateSelectString = this.dateSelect.text.toString();
          dateSplit = this.dateSelectString.split('/'); 
          saveLog = FirebaseFirestore.instance
            .collection('saveLog')
            .where('date', isEqualTo:  this.dateSelectString);
          this.typeReceived = true;
          this.typePay= true;
        });
        await getDataTransactionDay(dateSelectString).then((result) {
          this.setState(() {
            this.dataTransactionDay = result;
          });
        }).catchError((error) async {
          var totalTransactionDayModel = new TotalTransactionDayModel.addNewDate(dateSelectString);
          await totalTransactionDayModel.addNewTotalTransaction();
          await getDataTransactionDay(dateSelectString).then((result) {
            this.setState(() {
              this.dataTransactionDay = result;
            });
          });
        });
        await getDataAmountDay(dateSelectString).then((result) {
          this.setState(() {
            this.dataAmountDay = result;
          });
        }).catchError((error) async {
          var totalAmountDayModel = new TotalAmountDayModel.addNewDate(dateSelectString);
          await totalAmountDayModel.addNewTotalAmount();
          await getDataAmountDay(dateSelectString).then((result) {
            this.setState(() {
              this.dataAmountDay = result;
            });
          });
        });
        await getDataAmountMonth(dateSplit[1]+'/'+dateSplit[2]).then((result) {
          this.setState(() {
            this.dataAmountMonth = result;
          });
        }).catchError((error) async {
          var totalAmountMonthModel = new TotalAmountMonthModel.addNewDate(dateSplit[1]+'/'+dateSplit[2]);
          await totalAmountMonthModel.addNewTotalAmount();
          await getDataAmountMonth(dateSplit[1]+'/'+dateSplit[2]).then((result) {
            this.setState(() {
              this.dataAmountMonth = result;
            });
          });
        });
      })
      .catchError((error){
        print(error);
      });
  }
  Future getDataTransactionDay(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalTransactionsDay')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    List<String> totalEquals = [];
    totalEquals.add(querySnapshot.docs.first.id.toString());
    totalEquals.add(querySnapshot.docs.first.data()['amount'].toString());
    // print(totalEquals);
    return totalEquals;
  }
  Future getDataAmountDay(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalAmountDay')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    List<String> totalEquals = [];
    totalEquals.add(querySnapshot.docs.first.id.toString());
    totalEquals.add(querySnapshot.docs.first.data()['amount'].toString());
    // print(totalEquals);
    return totalEquals;
  }
  Future getDataAmountMonth(date) async {
    var respectsQuery = FirebaseFirestore.instance
        .collection('TotalAmountMonth')
        .where('date', isEqualTo: date);
    var querySnapshot = await respectsQuery.get();
    List<String> totalEquals = [];
    totalEquals.add(querySnapshot.docs.first.id.toString());
    totalEquals.add(querySnapshot.docs.first.data()['amount'].toString());
    // print(totalEquals);
    return totalEquals;
  }
}
