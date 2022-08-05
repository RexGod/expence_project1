// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:expence_project1/widget/chart.dart';
import 'package:flutter/material.dart';
import './widget/new_transaction.dart';
import './model/transitoin.dart';
import './widget/transaction_list.dart';
import './widget/chart.dart';

void main() => runApp(ExpenceApp());

// ignore: use_key_in_widget_constructors
class ExpenceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple,
      ),
      home: Expence(),
    );
  }
}

// ignore: use_key_in_widget_constructors,
class Expence extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ExpenceState createState() => _ExpenceState();
}

class _ExpenceState extends State<Expence> {
  final List<Transaction> _usertransaction = [];

  //when we pressed sumbite button or clicked on add transaction flat button the input transaction would add to our transaction list
  void _addNewTransaction(
      String newTitle, double newAmount, DateTime choosenDateTime) {
    final newTransactions =
        Transaction(title: newTitle, amount: newAmount, date: choosenDateTime);
    setState(() {
      _usertransaction.add(newTransactions);
    });
  }

  //showing transaction input when clicked the button
  void _showTransactionInput(BuildContext contxt) {
    showModalBottomSheet(
        context: contxt,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return _usertransaction.where((tx) {
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
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Expence App'),
        actions: [
          IconButton(
              onPressed: () => _showTransactionInput(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_usertransaction),
          ],
        ),
      ),
      //adding floating button
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => _showTransactionInput(
              context), //when pressed the button transaction input will invisible
          child: Icon(Icons.add)),
    );
  }
}
