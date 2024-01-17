import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paisa/models/expen.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _titleControlleram = TextEditingController();
  DateTime? _selectedDate;
  Catagory _selectedCategory = Catagory.travel;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpense() {
    final enteredAmmount = double.tryParse(_titleControlleram.text);
    final amountIsValid = enteredAmmount == null || enteredAmmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ivalid Input'),
          content: Text('Please enter valid all'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        date: _selectedDate!,
        title: _titleController.text,
        amount: enteredAmmount,
        catagory: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _titleControlleram.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 34,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _titleControlleram,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('amount'),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'Selected date'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: Icon(Icons.calendar_month_outlined))
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Catagory.values
                      .map(
                        (catagory) => DropdownMenuItem(
                          value: catagory,
                          child: Text(
                            catagory.name.toLowerCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpense();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
