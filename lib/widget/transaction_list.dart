import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../model/transitoin.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteOption;
  // ignore:, use_key_in_widget_constructors
  const TransactionList(this.transactions, this.deleteOption);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (contxt, Constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: Constraints.maxHeight * 0.1,
                  ),
                  Container(
                    height: Constraints.maxHeight * 0.6,
                    child: Image(image: AssetImage('assets/images/pngegg.png')),
                  ),
                  SizedBox(
                    height: Constraints.maxHeight * 0.1,
                  ),
                  Text(
                    "No Transaction Added yet!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            })
          //this is Transaction cards using map , list of Transaction
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text(
                          '\$ ${transactions[index].amount}',
                        )),
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date)),
                    trailing: IconButton(
                        onPressed: () => deleteOption(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        )),
                  ),
                );
              }),
            ),
    );
  }
}
