import 'package:flutter/material.dart';
import 'package:paisa/models/expen.dart';
class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical:15 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title.toUpperCase(),style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 4,),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                Spacer(),
                Row(children: [
                  Icon(catagoryIcon[expense.catagory]),
                  SizedBox(width: 8,),
                  Text(expense.formattedDate),
                ],),
              ],
            ),
          ],
        )
      ),
    );
  }
}
