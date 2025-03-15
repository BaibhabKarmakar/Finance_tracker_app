// convert datetime object into a string in the format "yyyymmdd";

String convertDateTimeToString(DateTime dateTime) {
  // year in the format (yyyy) : 
  String year = dateTime.year.toString();

  // month in the format (mm) : 
  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }

  // day in the format of (dd) : 
  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  // final format in (yyyymmdd) : 
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}