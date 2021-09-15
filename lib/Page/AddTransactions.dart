import 'package:cashlog/Model/saveLogModel.dart';
import 'package:cashlog/Widgets/Appbar/AppbarPop.dart';
import 'package:cashlog/Widgets/Button/ButtonIcon.dart';
import 'package:cashlog/Widgets/Button/ButtonText.dart';
import 'package:cashlog/Widgets/Button/ButtonTextActionLoading.dart';
import 'package:cashlog/Widgets/ShowAlertDialog.dart';
import 'package:cashlog/Widgets/TextField.dart';
import 'package:cashlog/Widgets/TextTitle.dart';
import 'package:cashlog/constant.dart';
import 'package:cashlog/routes.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cashlog/Widgets/ColorSet.dart';
import 'package:flutter/services.dart';

class AddTransactions extends StatefulWidget {
  @override
  _AddTransactionsState createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  late double screenWidth, screenHeight;
  late List<String> dataTransactionDay = [];
  late List<String> dataAmountDay = [];
  late List<String>  dataAmountMonth = [];
  late bool isClickButton = false;
  
  void initState(){
    super.initState();
    getDataTransactionDay(constant.thisDate).then((result) {
      this.setState(() {
        dataTransactionDay = result;
      });
    });
    getDataAmountDay(constant.thisDate).then((result) {
      this.setState(() {
        dataAmountDay = result;
      });
    });
    getDataAmountMonth(constant.thisMonthYear).then((result) {
      this.setState(() {
        dataAmountMonth = result;
      });
    });
    this.setState(() {
      dateSelect.text = constant.thisDate;
      timeSelect.text = constant.thisTime;
      moneyController.text = '0';
    });
  }

  var themeColor = new ColorSet();
  var constant = new Constant();
  var routes = Routes();

  var dateSelect = TextEditingController();
  var timeSelect = TextEditingController();
  var detailController = TextEditingController();
  var moneyController = TextEditingController();

  String type = 'received';
  String detail = '';

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: appbarPop(context, 'เพิ่มรายการ'),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 650.0, maxWidth: 650),
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 6),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textTitle('กรอกข้อมูลรายการที่ต้องการเพิ่ม',constant.textTitle, FontWeight.bold),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        textTitle('เลือกวันที่ : ', constant.textSubTitle, FontWeight.bold),
                        textFieldDate(dateSelect, Icon(Icons.date_range_sharp), 250),
                        textFieldDate(timeSelect, Icon(Icons.lock_clock), 115),
                        buttonIcon(context, () => onClickButtonDate(), null, Icons.date_range),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 20),
                        textTitle('เลือกประเภท : ', constant.textSubTitle, FontWeight.bold),
                        SizedBox(width: 20),
                        Radio(
                          value: 'received',
                          groupValue: type,
                          activeColor: themeColor.greenDark,
                          onChanged: (String? value) {
                            setState(() {type = value!;});
                          },
                        ),
                        textTitle('ได้รับ', constant.textSubTitle, FontWeight.w400),
                        Radio(
                          value: 'pay',
                          groupValue: type,
                          activeColor: themeColor.greenDark,
                          onChanged: (String? value) {
                            setState(() {type = value!;});
                          },
                        ),
                        textTitle('ใช้จ่าย', constant.textSubTitle, FontWeight.w400),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        textTitle('กรอกรายละเอียด : ', constant.textSubTitle, FontWeight.bold),
                        textFieldInput(detailController, Icon(Icons.text_fields), 400, FilteringTextInputFormatter.singleLineFormatter),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        if(type == 'received')
                          Row(
                            children: [
                              buttonSetText('ได้รับเงิน', themeColor.greenDark, () => onClickGetMoney()),
                              SizedBox(width: 10),
                              buttonSetText('ขายของได้กำไร', themeColor.greenDark, () => onClickSellItem()),
                            ],
                          )
                        else
                          Row(
                            children: [
                              buttonSetText('โอนเงินให้', themeColor.redDark, () => onClickTransfer()),
                              SizedBox(width: 10),
                              buttonSetText('ซื้อของใช้/ช็อปปิ้ง', themeColor.redDark, () => onClickBuyEtc()),
                              SizedBox(width: 10),
                              buttonSetText('เติมเกม', themeColor.redDark, () => onClickPayGame()),
                              SizedBox(width: 10),
                              buttonSetText('ไปเซเว่น', themeColor.redDark, () => onClick711()),
                            ],
                          )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        textTitle('กรอกจำนวนเงิน : ', constant.textSubTitle, FontWeight.bold),
                        textFieldInput(moneyController, Icon(Icons.money), 300, FilteringTextInputFormatter.digitsOnly),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        buttonSetText('100', themeColor.greenDark, () => onClick100()),
                        SizedBox(width: 10),
                        buttonSetText('500', themeColor.greenDark, () => onClick500()),
                        SizedBox(width: 10),
                        buttonSetText('1000', themeColor.redDark, () => onClick1000()),
                        SizedBox(width: 10),
                        buttonSetText('2000', themeColor.redDark, () => onClick2000()),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonTextActionLoading("เพิ่มรายการ", themeColor.greenLight, themeColor.greenDark, () => onClickAddTransactions(), isClickButton, 15)
                      ],
                    )
                  ]
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
  onClickCloseAlert(){
    this.setState(() {
      this.isClickButton = false;
    });
  }
  onClickAddTransactions() async {
    this.setState(() {
      isClickButton = true;
    });
    if(detailController.text != '' && moneyController.text != ''){
      var saveLogModel = SaveLogModel(
        dateSelect.text,
        timeSelect.text,
        detailController.text,
        this.type,
        double.parse(moneyController.text),
        constant.thisMonthYear,
        dataTransactionDay,
        dataAmountDay,
        dataAmountMonth,
      );
      await saveLogModel.addSaveLog();
      Navigator.popUntil(
        context,
        ModalRoute.withName(routes.dashboard['name']),
      );
    }
    else{
      dialogCustom(
        context,
        'ไม่สามารถเพิ่มรายการได้ ! ! !',
        'กรุณากรอกรายละเอียดและจำนวนเงินให้ครบถ้วน',
        () => onClickCloseAlert(),
        themeColor.redLight
      );
    }
  }         
  onClickButtonDate(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 7, 23),
      lastDate: DateTime.now(),
    )
      .then((date) async {
        // 2021-07-18T00:00:00.000
        late String dateFormatSelect = date!.toIso8601String();
        List<String> dateAndTimeSelect = dateFormatSelect.split('T');
        List<String> dateSplitSelect = dateAndTimeSelect[0].split('-');
      
        dateSelect.text = '${dateSplitSelect[2]}/'+'${dateSplitSelect[1]}/'+'${dateSplitSelect[0]}';
        timeSelect.text = constant.thisTime;

        await getDataTransactionDay(dateSelect.text).then((result) {
          this.setState(() {
            dataTransactionDay = result;
          });
        });
        await getDataAmountDay(dateSelect.text).then((result) {
          this.setState(() {
            dataAmountDay = result;
          });
        });
        await getDataAmountMonth(dateSplitSelect[1]+'/'+dateSplitSelect[0]).then((result) {
          this.setState(() {
            dataAmountMonth = result;
          });
        });
      })
      .catchError((error){
        print(error);
      });
  }     
  onClickGetMoney(){
    detailController.text = 'ได้รับเงิน';    
  }
  onClickSellItem(){
    detailController.text = 'ขายของได้กำไร';    
  }
  ///////////////////////////////////////////////////////////////////////////
  onClickTransfer(){
    detailController.text = 'โอนเงินให้ ...';    
  }
  onClickPayGame(){
    detailController.text = 'เติมเกม';    
  }
  onClick711(){
    detailController.text = 'ไปเซเว่น';    
  }
  onClickBuyEtc(){
    detailController.text = 'ซื้อของใช้/ช็อปปิ้ง';
  }
  ///////////////////////////////////////////////////////////////////////////
  onClick100(){
    moneyController.text = '100';    
  }
  onClick500(){
    moneyController.text = '500';    
  }
  onClick1000(){
    moneyController.text = '1000';    
  }
  onClick2000(){
    moneyController.text = '2000';    
  }
  ///////////////////////////////////////////////////////////////////////////
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
