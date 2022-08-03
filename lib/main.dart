import '../widgets/chart.dart';
import '../widgets/transaction_list.dart';
import '../models/transaction.dart';
import '../widgets/new_transaction.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expanses',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          errorColor: Color.fromARGB(255, 179, 48, 39),
          accentColor: Color.fromARGB(255, 165, 83, 180),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: '1',
    //     title: 'New Shoes',
    //     amountMoney: 69.99,
    //     dateTime: DateTime.now()),
    // Transaction(
    //     id: '2',
    //     title: 'Weekly Groceries',
    //     amountMoney: 15.98,
    //     dateTime: DateTime.now())
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double amount, DateTime choosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amountMoney: amount,
        dateTime: choosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTrasaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ],
        title: Text(
          'Expanses App',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(_recentTransaction),
            TransactionList(_userTransaction, _deleteTrasaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
