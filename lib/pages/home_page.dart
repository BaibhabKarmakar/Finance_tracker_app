import 'package:finance_tracker_app/components/expense_summary.dart';
import 'package:finance_tracker_app/components/expense_tile.dart';
import 'package:finance_tracker_app/data/expense_data.dart';
import 'package:finance_tracker_app/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers :
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // prepare data on Startup :
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseData>(context, listen: false).prepareData();
    });
  }

  // add new expense :
  void addNewExpense() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add new Expense!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name of the expense :
                TextField(controller: newExpenseNameController),

                // Amount of the expense :
                TextField(
                  controller: newExpenseAmountController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              // save button :
              MaterialButton(onPressed: save, child: Text("save")),
              // cancel button :
              MaterialButton(onPressed: cancel, child: Text("Cancel")),
            ],
          ),
    );
  }

  // delete expense method :
  void deleteExpense(ExpenseItem expense) {
    // delete the expense :
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
    Navigator.pop(context);
  }

  // save method :
  void save() {
    // only save when all field s are filled!
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseAmountController.text.isNotEmpty) {
      // create expense Item :
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now(),
      );
      // Add the new Expense :
      Provider.of<ExpenseData>(
        context,
        listen: false,
      ).addNewExpense(newExpense);

      Navigator.pop(context);
      clear();
    }
  }

  // Cancel Method :
  void cancel() {
    Navigator.pop(context);
  }

  // clear the controllers :
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.grey[900],
            child: Icon(Icons.add, color: Colors.grey[300]),
          ),
          body: Column(
            children: [
              // Weekly summary bar graph (Fixed at the top)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              ),

              SizedBox(height: 20), // Spacing

              Text("All Expenses", style: TextStyle(fontSize: 22 ,)),
              // Expense List (Scrollable)
              Expanded(
                child: value.getAllExpenseList().isEmpty
                    ? Center(
                      child: Text(
                        "No expenses yet!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    )
                    : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: value.getAllExpenseList().length,
                      itemBuilder: (context, index) {
                        final expense = value.getAllExpenseList()[index];
                
                        return ExpenseTile(
                          name: expense.name,
                          amount: expense.amount,
                          dateTime: expense.dateTime,
                          deleteTapped: (p0) {
                            value.deleteExpense(expense);
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
