
import 'package:finance_tracker_app/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;

class HiveDataBase {
  // reference our box that is already open in the database : 
  final _myBox = Hive.box("Expense_database");
  // writing data : 
  void saveData(List<ExpenseItem> allExpense) {
    // In hive we can only store primitive datatypes ; not any custom datatypes . 
    // So we will convert the custom datatype into primitive datatypes :

    /* 
    allExpense = [
      ExpenseItem(name / amount / dateTime),
    ],
    */

    List<List<dynamic>> allExpenseFormatted = [];

    for(var expense in allExpense) {
      // convert all objects into a list storable types (Strings , dateTime):
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ]; 
      allExpenseFormatted.add(expenseFormatted);
    }

    // finally storing it into our database : 
    _myBox.put("ALL_EXPENSES" , allExpenseFormatted);
  }
  // reading data : 
  List<ExpenseItem> readData() {
    /* 
    Data is stored in Hive as a list of Strings + dateTime : 
    so let's convert our saved data into ExpenseItem objects : 
    */
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for(int i=0 ; i < savedExpenses.length ; i++) {
      // collecting the individual expense Data : 
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // creating the new expense object : 
      ExpenseItem newExpense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime
      );

      // adding the new expense to the list :
      allExpenses.add(newExpense);
    }
    return allExpenses;
  }

}