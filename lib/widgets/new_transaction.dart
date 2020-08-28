import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void onSubmit() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    addTransaction(
      title: title,
      amount: amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Price',
                prefixText: '₹ ',
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => onSubmit(),
            ),
            FlatButton(
              onPressed: onSubmit,
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
