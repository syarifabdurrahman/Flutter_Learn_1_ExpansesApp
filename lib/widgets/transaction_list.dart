import 'package:assigment_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function deleteTx;

  TransactionList(this._userTransaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _userTransaction.isEmpty // checking if emty
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                // need item builder
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                                  '\$ ${_userTransaction[index].amountMoney}')),
                        ),
                      ),
                      title: Text(_userTransaction[index].title,
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(DateFormat.yMMMd()
                          .format(_userTransaction[index].dateTime)),
                      trailing: IconButton(
                        onPressed: () => deleteTx(_userTransaction[index]
                            .id), // for passing reference to the function with anonymous function
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                      )),
                );
              },
              itemCount: _userTransaction
                  .length, // need this for counting scrollable items
            ),
    );
  }
}
