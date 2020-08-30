import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  DateTime pickedDate;

  void onSubmit() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || pickedDate == null) {
      return;
    }

    widget.addTransaction(
      title: title,
      amount: amount,
      date: pickedDate,
    );
    Navigator.pop(context);
  }

  void startDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.parse("2020-01-01 00:00:01Z"),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      pickedDate = value;
      dateController.text = DateFormat.yMMMd().format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            18,
          ),
        ),
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
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
                onSubmitted: (_) => startDatePicker(),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: dateController,
                        decoration: InputDecoration(labelText: 'Date'),
                        enabled: false,
                      ),
                    ),
                    FlatButton(
                      onPressed: startDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: onSubmit,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
