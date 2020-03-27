import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addex;
  AddTransaction(this.addex);
  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    widget.addex(_titlecontroller.text, double.parse(_amountcontroller.text),
        _selectedDate);

    Navigator.of(context).pop();
  }

  void _openDT() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Enter Title'),
              keyboardType: TextInputType.text,
              controller: _titlecontroller,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Amount'),
              keyboardType: TextInputType.number,
              controller: _amountcontroller,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'Select Date'
                        : 'Selected Date ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    onPressed: _openDT,
                    child: Text('Choose Date'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submitData,
              child: Text('Add Expense'),
            )
          ],
        ),
      ),
    );
  }
}
