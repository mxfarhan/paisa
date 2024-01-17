import 'package:flutter/material.dart';
import 'package:paisa/models/new_expense.dart';
import 'package:paisa/widgets/expensis_list.dart';
import 'package:paisa/models/expen.dart';

class Expensis extends StatefulWidget {
  const Expensis({super.key});

  @override
  State<Expensis> createState() {
    return _ExpensisState();
  }
}

class _ExpensisState extends State<Expensis> {
  final List<Expense> _rigisteredExpense = [
    Expense(
        date: DateTime.now(),
        title: 'Flutter',
        amount: 12.3,
        catagory: Catagory.food),
    Expense(
        date: DateTime.now(),
        title: 'books',
        amount: 32.3,
        catagory: Catagory.call),
    Expense(
        date: DateTime.now(),
        title: 'Pen',
        amount: 11.3,
        catagory: Catagory.work),
  ];
  void _openAddoverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _rigisteredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex=_rigisteredExpense.indexOf(expense);
    setState(() {
      _rigisteredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              _rigisteredExpense.insert(expenseIndex, expense);
            });
          },
          
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expense found'),
    );
    if (_rigisteredExpense.isNotEmpty) {
      mainContent = ExpensisList(
        expenses: _rigisteredExpense,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddoverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
         // const Text('Chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
