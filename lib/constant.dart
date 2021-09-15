class Constant{
  // 2021-07-18T00:00:00.000
  String getDate = DateTime.now().toIso8601String();
  late List<String> dateAndTimeNow = getDate.split('T');
  late List<String> dateNow = dateAndTimeNow[0].split('-');
  late List<String> timeNow = dateAndTimeNow[1].split(':');

  late String thisDay = dateNow[2];
  late String thisMonth = dateNow[1];
  late String thisYear = dateNow[0];
  late String thisDate = '$thisDay/'+'$thisMonth/'+'$thisYear';
  late String thisMonthYear = '$thisMonth/'+'$thisYear';
  late String thisTime = '${timeNow[0]}:'+'${timeNow[1]}';

  late double textTitle = 20;
  late double textSubTitle = 18;
  late double textDetail = 16;
  late double textSubDetail = 14;
  late double textMini = 12;
}