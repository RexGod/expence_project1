// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:expence_project1/widget/chart.dart';
import 'package:flutter/material.dart';
import './widget/new_transaction.dart';
import './model/transitoin.dart';
import './widget/transaction_list.dart';
import './widget/chart.dart';

void main() {
  runApp(ExpenceApp());
}

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
    final newTransactions = Transaction(
        title: newTitle,
        amount: newAmount,
        date: choosenDateTime,
        id: DateTime.now().toString());
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteTransation(String id) {
    setState(() {
      _usertransaction.removeWhere((del) {
        return del.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text('Expence App'),
      actions: [
        IconButton(
            onPressed: () => _showTransactionInput(context),
            icon: Icon(Icons.add))
      ],
    );
    final mediaQuery = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                children: [
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                  Text('Show Chart')
                ],
              ),
            if (!isLandScape)
              Container(
                  height: (mediaQuery -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!isLandScape)
              Container(
                  height: (mediaQuery -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: TransactionList(_usertransaction, deleteTransation)),
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.8,
                      child: Chart(_recentTransactions))
                  : Container(
                      height: (mediaQuery -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child:
                          TransactionList(_usertransaction, deleteTransation)),
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
