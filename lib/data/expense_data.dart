import 'package:finance_tracker_app/data/hive_database.dart';
import 'package:finance_tracker_app/datetime/date_time_helper.dart';
import 'package:finance_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{

  // list of all expenses : 
  List<ExpenseItem> overallExpenseList = [];
  // get expense list : 
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }
  final db = HiveDataBase();
  // prepare data to display : 
  void prepareData() {
    if(db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
      notifyListeners();
    }
  }
  // add new expense : 
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }
  // delete an existing expense : 
  void deleteExpense(ExpenseItem expense) {
  if (overallExpenseList.contains(expense)) {
    overallExpenseList.remove(expense);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
      db.saveData(overallExpenseList);
    });
  }
}
  // get weekday (Mon , tue , wed etc.) from a dataTime object : 
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return " ";
    }
  }
  // get the date for the start of the week (sunday): 
  DateTime startOfWeekDate() {
    DateTime? startOfWeek; 

    // get today's date : 
    DateTime today = DateTime.now();

    // go backwards from today to find sunday : 
    for(int i=0 ; i < 7 ; i++) {
      if(getDayName(today.subtract(Duration(days : i))) == "Sun") {
        startOfWeek = today.subtract(Duration(days : i));
      }
    }

    return startOfWeek!;
  } 
  /* 
    convert overall the list of expenses into a daily expense summary : 

    overallExpenseList = 
    [
      [
        food , date : 13/03/25 , ₹150
      ]
      [
        travel , date : 13/03/25 , ₹500
      ]
      [
        grocery , date : 13/03/25 , ₹200
      ]
      [
        travel , date : 14/03/25 , ₹500
      ]
      [
        grocery , date : 14/03/25 , ₹200
      ]
      [
        travel , date : 14/03/25 , ₹500
      ]
      [
        grocery , date : 15/03/25 , ₹200
      ]
    ],

    -> 

    DailyExpenseSummary = 
    [
      [
        date : 13/03/25 , ₹850
      ],
      [
        date : 14/03/25 , ₹1200
      ],
      [
        date : 15/03/25 , ₹200
      ]
    ]
  */

  Map<String , double> calculateDailyExpenseSummary() {
    Map<String , double> dailyExpenseSummary = {
      // date (yymmdd) : amountTotalForDay ; 

    };

    for(var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }
      else {
        dailyExpenseSummary.addAll({date : amount});
      }
    }
    return dailyExpenseSummary;
  }

  calculateWeeklyExpenseSummary() {}

  calculateWeekTotal() {}
}