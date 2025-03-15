import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical : 10 , horizontal : 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // delete button : 
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius : BorderRadius.circular(10)
            ),
            // // Edit button : 
            // SlidableAction(
            //   onPressed: deleteTapped,
            //   backgroundColor: Colors.green,
            //   icon: Icons.edit,
            //   label: 'Delete',
            //   borderRadius : BorderRadius.circular(10)
            // ),
          ],
        ),
        child: ListTile(
          shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(name),
          subtitle: Text(
            '${dateTime.day} / ${dateTime.month} / ${dateTime.year}',
          ),
          trailing: Text('₹$amount'),
        ),
      ),
    );
  }
}
