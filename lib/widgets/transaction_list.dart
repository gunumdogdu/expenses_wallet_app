import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: FittedBox(
                        child: Text(
                          '\₺${transactions[index].amount}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    backgroundColor: Colors.amber,
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  subtitle: Text(
                    style: Theme.of(context).textTheme.bodySmall,
                    DateFormat.yMMMd().format(
                      transactions[index].date,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
