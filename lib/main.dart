import 'package:finance_tracker_app/data/expense_data.dart';
import 'package:finance_tracker_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async{
  // initialize hive : 
  await Hive.initFlutter();
  // open a hive box : 
  await Hive.openBox("Expense_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context , child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(), 
      )
    );
  }
}