import './widgets/chart.dart';

import './widgets/addtransaction.dart';
import './widgets/transactionlist.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pink,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listTransactions = [
    Transaction(id: 't1', title: 'milk', amount: 150, date: DateTime.now()),
    Transaction(id: 't2', title: 'butter', amount: 70, date: DateTime.now()),
  ];

  void _deltrans(String id) {
    setState(() {
      _listTransactions.removeWhere((x) => x.id == id);
    });
  }

  void _addnewexpense(String extitle, double examount, DateTime exdt) {
    final newex = Transaction(
        id: DateTime.now().toString(),
        title: extitle,
        amount: examount,
        date: exdt);

    setState(() {
      _listTransactions.add(newex);
    });
  }

  void _openaddexpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: AddTransaction(_addnewexpense),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _listTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_listTransactions, _deltrans),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openaddexpense(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
