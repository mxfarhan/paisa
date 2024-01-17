import 'package:flutter/material.dart';
import 'package:paisa/models/expen.dart';
import 'package:paisa/widgets/expenses_items.dart';
class ExpensisList extends StatelessWidget {
  const ExpensisList({super.key,required this.expenses,required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenses.length,itemBuilder: (context, index) {
      return Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.5),
          margin: EdgeInsets.symmetric(horizontal: 16),
          ),
          onDismissed: (direction){onRemoveExpense(expenses[index]);
            },
          child: ExpenseItem(expenses[index]));
    },
    );
  }
}
